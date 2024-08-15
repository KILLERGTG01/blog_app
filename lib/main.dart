import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/blog_bloc.dart';
import 'services/blog_service.dart';
import 'screens/blog_list_screen.dart';

void main() {
  final BlogService blogService = BlogService();

  runApp(
    BlocProvider(
      create: (context) => BlogBloc(blogService: blogService)..add(LoadBlogs()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog Explorer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BlogListScreen(),
    );
  }
}