import 'package:flutter/material.dart';
import '../models/blog_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blog_bloc.dart';

class BlogDetailScreen extends StatelessWidget {
  final Blog blog;

  const BlogDetailScreen({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title),
        actions: [
          IconButton(
            icon: Icon(
              blog.isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            onPressed: () {
              context.read<BlogBloc>().add(ToggleFavorite(blog: blog));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(blog.imageUrl),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(blog.content),
            ),
          ],
        ),
      ),
    );
  }
}
