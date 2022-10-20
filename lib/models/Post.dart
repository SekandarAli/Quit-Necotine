import 'package:nicotine/models/PostComment.dart';
import 'package:nicotine/models/PostLike.dart';
import 'package:nicotine/models/User.dart';

class Post {
  String? postId;
  User? user;
  String? postDescription;
  String? postImage;
  List<PostLike>? postLikes;
  List<PostComment>? postComments;
  DateTime? postCreated;

  Post(
      {required this.postId,
      required this.user,
      required this.postDescription,
      required this.postImage,
      required this.postLikes,
      required this.postComments,
      required this.postCreated});

  Post.fromJson(Map<String, dynamic> json) {
    this.postId = json['postId'] ?? "";
    this.user = User.fromJson(json['user']);
    this.postDescription = json['postDescription'] ?? "";
    this.postImage = json['postImage'] ?? "";
    final allPostLikeLists = json['postLikes'];
    List<PostLike> allLikes = [];
    if (allPostLikeLists != null) {
      allPostLikeLists.forEach((e) {
        final currentLikes = e as Map<String, dynamic>;
        allLikes.add(PostLike.fromJson(currentLikes));
      });
    }
    this.postLikes = allLikes;

    final allPostCommentLists = json['postComments'];
    List<PostComment> allComments = [];
    if (allPostCommentLists != null) {
      allPostCommentLists.forEach((e) {
        final currentComment = e as Map<String, dynamic>;
        allComments.add(PostComment.fromJson(currentComment));
      });
    }
    this.postComments = allComments;
    this.postCreated = json['postCreated'] != null
        ? DateTime.parse(json['postCreated'])
        : DateTime.now();
  }
}
