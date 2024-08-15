import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/blog_model.dart';
import 'database_service.dart';
import '../utils/constants.dart';

class BlogService {
  final String apiUrl = Constants.apiUrl;
  final String apiKey = Constants.apiKey;
  final DatabaseService _databaseService = DatabaseService();

  Future<List<Blog>> fetchBlogs() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'x-hasura-admin-secret': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final blogs = data['blogs'] as List<dynamic>;

        // Save blogs to local database
        await _databaseService.clearBlogs();
        for (var blogJson in blogs) {
          final blog = Blog.fromJson(blogJson);
          await _databaseService.insertBlog(blog);
        }

        return blogs.map((json) => Blog.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load blogs');
      }
    } catch (e) {
      // On error, fetch blogs from local database
      return await _databaseService.getBlogs();
    }
  }
}