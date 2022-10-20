import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nicotine/models/Post.dart';
import 'package:nicotine/models/PostComment.dart';
import 'package:nicotine/models/PostLike.dart';

import '../../models/User.dart';

class ForumFirestoreService {
  final String collectionName = "forum";

  // Future<void> checkAffirmationDone(Affirmation currentAffirmation) async {
  //   print("ForumFirestoreService: checkAffirmationDone Function");

  //   try {
  //     final Map<String, dynamic> affirmationMap = {
  //       "affirmationId": currentAffirmation.affirmationId,
  //       "userEmail": Storage.getValue("UserEmail") ?? "emptyEmail",
  //       "dateTime": currentAffirmation.dateTime!.toIso8601String(),
  //       "affirmationMessage": currentAffirmation.affirmationMessage,
  //       "isMorning": currentAffirmation.isMorning,
  //       "isMidDay": currentAffirmation.isMidDay,
  //       "isNight": currentAffirmation.isNight,
  //       "isMorningDone": currentAffirmation.isMorningDone,
  //       "isMidDayDone": currentAffirmation.isMidDayDone,
  //       "isNightDone": currentAffirmation.isNightDone,
  //       "isDone": currentAffirmation.isDone,
  //     };

  //     FirebaseFirestore.instance
  //         .collection(collectionName)
  //         .doc(currentAffirmation.affirmationId)
  //         .set(affirmationMap)
  //         .catchError((e) {
  //       print(e.toString());
  //     });
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }

  Future<bool> createPost(
    User user,
    String postDescription,
    String postImage,
  ) async {
    print("ForumFirestoreService: createPost Function");
    String postId = DateTime.now().toIso8601String() + "_" + user.userEmail!;
    // DateTime.now().toIso8601String() + Storage.getValue("UserEmail");
    try {
      final image = File(postImage);
      List<int> imageBytes = await image.readAsBytes();

      final base64Image = base64Encode(imageBytes);

      final Map<String, dynamic> postMap = {
        "postId": postId,
        "user": user.toJson(user),
        "postDescription": postDescription,
        "postImage": base64Image,
        "postLikes": [],
        "postComments": [],
        "postCreated": DateTime.now().toIso8601String(),
      };
      FirebaseFirestore.instance
          .collection(collectionName)
          .doc(postId)
          .set(postMap)
          .catchError((e) {
        print(e.toString());
      });
      // FirebaseFirestore.instance.collection(collectionName).add(affirmationMap);
      return true;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> updateAPost(
    User user,
    Post post,
    String postDescription,
    String postImage,
  ) async {
    print("ForumFirestoreService: updateAPost Function");
    // String postId = DateTime.now().toIso8601String() + "_" + user.userEmail!;
    // DateTime.now().toIso8601String() + Storage.getValue("UserEmail");
    try {
      final image = File(postImage);
      List<int> imageBytes = await image.readAsBytes();

      final base64Image = base64Encode(imageBytes);

      final Map<String, dynamic> postMap = {
        "postId": post.postId,
        "user": user.toJson(user),
        "postDescription": postDescription,
        "postImage": base64Image,
        "postLikes": post.postLikes,
        "postComments": post.postComments,
        "postCreated": post.postCreated!.toIso8601String(),
      };
      FirebaseFirestore.instance
          .collection(collectionName)
          .doc(post.postId)
          .set(postMap)
          .catchError((e) {
        print(e.toString());
      });
      // FirebaseFirestore.instance.collection(collectionName).add(affirmationMap);
      return true;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Post>> getAllForumPosts() async {
    print("ForumFirestoreService: getAllForumPosts Function");
    try {
      var map = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc()
          .snapshots();
      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection(collectionName);

      QuerySnapshot querySnapshot = await _collectionRef.get();

      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();

      print(allData);

      List<Post> allPosts = [];
      allData.forEach((item) {
        final affirm = item as Map<String, dynamic>;
        // if (affirm["user"]["userId"] == Storage.getValue("userId")) {
        allPosts.add(Post.fromJson(affirm));
        // }
      });
      print("All Posts: ${allPosts.length}");

      return allPosts.reversed.toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> likePost(User user, Post post) async {
    print("ForumFirestoreService: likePost Function");

    bool postFound = false;

    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .where("postId", isEqualTo: post.postId)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          postFound = true;

          PostLike postLike =
              PostLike(userLikeId: user.userId, postId: post.postId);
          List<PostLike> postLikes = post.postLikes!;

          postLikes.add(postLike);
          List<Map<String, dynamic>> postLikesUpload = [];
          postLikes.forEach((element) {
            postLikesUpload.add(element.toJson(element));
          });

          List<Map<String, dynamic>> postCommentsUpload = [];
          post.postComments!.forEach((element) {
            postCommentsUpload.add(element.toJson(element));
          });

          final Map<String, dynamic> postMap = {
            "postId": post.postId,
            "user": post.user!.toJson(post.user!),
            "postDescription": post.postDescription,
            "postImage": post.postImage,
            "postLikes": postLikesUpload,
            "postComments": postCommentsUpload,
            "postCreated": DateTime.now().toIso8601String(),
          };

          FirebaseFirestore.instance
              .collection(collectionName)
              .doc(post.postId)
              .set(postMap)
              .catchError((e) {
            print(e.toString());
          });
        });
      });
      if (!postFound) {
        print("Email not found");
        throw "Email not found";
      }

      return true;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> removeLikeFromAPost(User user, Post post) async {
    print("ForumFirestoreService: removeLikeFromAPost Function");

    bool postFound = false;

    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .where("postId", isEqualTo: post.postId)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          postFound = true;

          PostLike postLike =
              PostLike(userLikeId: user.userId, postId: post.postId);
          List<PostLike> postLikes = post.postLikes!;

          List<Map<String, dynamic>> postLikesUpload = [];
          postLikes.forEach((element) {
            if (element.userLikeId != user.userId) {
              postLikesUpload.add(element.toJson(element));
            }
          });

          List<Map<String, dynamic>> postCommentsUpload = [];
          post.postComments!.forEach((element) {
            postCommentsUpload.add(element.toJson(element));
          });

          final Map<String, dynamic> postMap = {
            "postId": post.postId,
            "user": post.user!.toJson(post.user!),
            "postDescription": post.postDescription,
            "postImage": post.postImage,
            "postLikes": postLikesUpload,
            "postComments": postCommentsUpload,
            "postCreated": DateTime.now().toIso8601String(),
          };

          FirebaseFirestore.instance
              .collection(collectionName)
              .doc(post.postId)
              .set(postMap)
              .catchError((e) {
            print(e.toString());
          });
        });
      });
      if (!postFound) {
        print("Email not found");
        throw "Email not found";
      }

      return true;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> commentAPost(User user, Post post, String comment) async {
    print("ForumFirestoreService: commentAPost Function");

    bool postFound = false;

    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .where("postId", isEqualTo: post.postId)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          postFound = true;
          String commentId =
              DateTime.now().toIso8601String() + "_" + user.userEmail!;
          PostComment postComment = PostComment(
            postCommentId: commentId,
            userWhoCommentedId: user.userId,
            postId: post.postId,
            postCommentText: comment,
            commentByUserEmail: user.userEmail,
            commentByUserName: user.userName,
            commentTime: DateTime.now().toIso8601String(),
          );
          List<PostLike> postLikes = post.postLikes!;

          List<Map<String, dynamic>> postLikesUpload = [];
          postLikes.forEach((element) {
            postLikesUpload.add(element.toJson(element));
          });

          List<PostComment> postComments = post.postComments!;

          postComment.postCommentId = commentId;
          postComments.add(postComment);

          List<Map<String, dynamic>> postCommentsUpload = [];

          postComments.forEach((element) {
            postCommentsUpload.add(element.toJson(element));
          });

          final Map<String, dynamic> postMap = {
            "postId": post.postId,
            "user": post.user!.toJson(post.user!),
            "postDescription": post.postDescription,
            "postImage": post.postImage,
            "postLikes": postLikesUpload,
            "postComments": postCommentsUpload,
            "postCreated": DateTime.now().toIso8601String(),
          };

          FirebaseFirestore.instance
              .collection(collectionName)
              .doc(post.postId)
              .set(postMap)
              .catchError((e) {
            print(e.toString());
          });
        });
      });

      if (!postFound) {
        print("Email not found");
        throw "Email not found";
      }

      return true;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> deletePost(String postId) async {
    print("ForumFirestoreService: deletePost Function");
    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(postId)
          .delete();

      return true;
    } catch (e) {
      throw e.toString();
    }
  }
}
