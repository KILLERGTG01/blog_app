import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/blog_model.dart';
import 'database_service.dart';
import '../utils/constants.dart';
import '../utils/logger.dart'; // Import the logger

class BlogService {
  final String apiUrl = Constants.apiUrl;
  final String apiKey = Constants.apiKey;
  final DatabaseService _databaseService = DatabaseService();

  Future<List<Blog>> fetchBlogs() async {
    try {
      logger.info("Fetching blogs from API...");
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'x-hasura-admin-secret': apiKey,
        },
      );

      if (response.statusCode == 200) {
        logger.info("API call successful. Parsing response...");
        final data = json.decode(response.body);
        logger.fine("API response data received successfully.");
        final blogs = data['blogs'] as List<dynamic>;

        // Save blogs to local database
        await _databaseService.clearBlogs();
        for (var blogJson in blogs) {
          final blog = Blog.fromJson(blogJson);
          await _databaseService.insertBlog(blog);
        }

        return blogs.map((json) => Blog.fromJson(json)).toList();
      } else {
        logger.severe("API call failed with status: ${response.statusCode}");
        throw Exception('Failed to load blogs');
      }
    } catch (e, stackTrace) {
      logger.severe("Error occurred while fetching blogs from API", e, stackTrace);
      // On error, fetch blogs from local database
      final localBlogs = await _databaseService.getBlogs();
      if (localBlogs.isEmpty) {
        logger.warning("No local blogs available.");
      } else {
        logger.info("Loaded blogs from local database.");
      }
      return localBlogs;
    }
  }
}
