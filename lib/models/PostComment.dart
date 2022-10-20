import 'package:nicotine/models/User.dart';

class PostComment {
  String? postCommentId;
  String? userWhoCommentedId;
  String? postId;
  String? postCommentText;
  String? commentByUserName;
  String? commentByUserEmail;
  String? commentTime;

  PostComment({
    required this.postCommentId,
    required this.userWhoCommentedId,
    required this.postId,
    required this.postCommentText,
    required this.commentByUserName,
    required this.commentByUserEmail,
    required this.commentTime,
  });

  PostComment.fromJson(Map<String, dynamic> json) {
    this.postCommentId = json['postCommentId'] ?? "";
    this.userWhoCommentedId = json['userWhoCommentedId'] ?? "";
    this.postId = json['postId'] ?? "";
    this.postCommentText = json['postCommentText'] ?? "";

    this.commentByUserName = json['commentByUserName'] ?? "";
    this.commentByUserEmail = json['commentByUserEmail'] ?? "";
    this.commentTime = json['commentTime'] ?? "";
  }
  Map<String, dynamic> toJson(PostComment postComment) {
    Map<String, dynamic> postCommentMap = {
      "postCommentId": postComment.postCommentId,
      "userWhoCommentedId": postComment.userWhoCommentedId,
      "postId": postComment.postId,
      "postCommentText": postComment.postCommentText,
      "commentByUserName": postComment.commentByUserName,
      "commentByUserEmail": postComment.commentByUserEmail,
      "commentTime": postComment.commentTime,
    };
    return postCommentMap;
  }
}
