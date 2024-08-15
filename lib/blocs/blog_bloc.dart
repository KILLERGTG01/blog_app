import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/blog_model.dart';
import '../services/blog_service.dart';

abstract class BlogEvent {}

class LoadBlogs extends BlogEvent {}

class ToggleFavorite extends BlogEvent {
  final Blog blog;

  ToggleFavorite({required this.blog});
}

abstract class BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final List<Blog> blogs;

  BlogLoaded({required this.blogs});
}

class BlogError extends BlogState {}

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogService blogService;

  BlogBloc({required this.blogService}) : super(BlogLoading()) {
    on<LoadBlogs>(_onLoadBlogs);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadBlogs(LoadBlogs event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    try {
      final blogs = await blogService.fetchBlogs();
      emit(BlogLoaded(blogs: blogs));
    } catch (error) {
      emit(BlogError());
    }
  }

  void _onToggleFavorite(ToggleFavorite event, Emitter<BlogState> emit) {
    if (state is BlogLoaded) {
      final updatedBlogs = (state as BlogLoaded).blogs.map((blog) {
        return blog.id == event.blog.id
            ? blog.copyWith(isFavorite: !blog.isFavorite)
            : blog;
      }).toList();
      emit(BlogLoaded(blogs: updatedBlogs));
    }
  }
}