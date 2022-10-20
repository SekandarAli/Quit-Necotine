part of 'forum_bloc.dart';

@immutable
abstract class ForumState {}

class ForumInitial extends ForumState {}

class AllPostsRetrieved extends ForumState {
  final List<Post> posts;
  AllPostsRetrieved({
    required this.posts,
  });
}

class PostAdded extends ForumState {}

class ForumError extends ForumState {
  final String error;
  ForumError({required this.error});
}
