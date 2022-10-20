part of 'forum_bloc.dart';

@immutable
abstract class ForumEvent {}

class GetAllForumPosts extends ForumEvent {}

class GetCurrentPost extends ForumEvent {}

// class UpdateAffirmation extends AffirmationsEvent {
//   final Affirmation affirmation;
//   UpdateAffirmation({
//     required this.affirmation,
//   });
// }

class CreateAPost extends ForumEvent {
  final User user;
  final String postDescription, postImage;

  CreateAPost({
    required this.user,
    required this.postDescription,
    required this.postImage,
  });
}

class EditAPost extends ForumEvent {
  final User user;
  final Post post;
  final String postDescription, postImage;

  EditAPost({
    required this.user,
    required this.post,
    required this.postDescription,
    required this.postImage,
  });
}

class LikeAPost extends ForumEvent {
  final User user;
  final Post post;

  LikeAPost({
    required this.user,
    required this.post,
  });
}

class RemoveLikeFromAPost extends ForumEvent {
  final User user;
  final Post post;

  RemoveLikeFromAPost({
    required this.user,
    required this.post,
  });
}

class CommentAPost extends ForumEvent {
  final User user;
  final Post post;
  final String comment;

  CommentAPost({
    required this.user,
    required this.post,
    required this.comment,
  });
}

class RemoveCommentOnAPost extends ForumEvent {
  final User user;
  final Post post;
  final String comment;

  RemoveCommentOnAPost({
    required this.user,
    required this.post,
    required this.comment,
  });
}

class DeleteAPost extends ForumEvent {
  final String postId;

  DeleteAPost({
    required this.postId,
  });
}

class ResetForumState extends ForumEvent {}
