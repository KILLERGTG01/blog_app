import 'package:flutter/material.dart';
import '../models/blog_model.dart';
import '../screens/blog_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BlogItem extends StatelessWidget {
  final Blog blog;

  const BlogItem({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: blog.imageUrl,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      title: Text(blog.title),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogDetailScreen(blog: blog),
          ),
        );
      },
    );
  }
}