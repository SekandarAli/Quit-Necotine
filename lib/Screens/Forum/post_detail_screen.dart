import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nicotine/blocs/Forum/forum_bloc.dart';
import 'package:nicotine/blocs/User/user_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:sizer/sizer.dart';

import '../../models/Post.dart';
import '../../utils/date_util.dart';
import '../Components/snackBar.dart';

class PostDetailScreen extends StatefulWidget {
  final Post thisPost;
  const PostDetailScreen({required this.thisPost, Key? key}) : super(key: key);

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  bool seenMore = false;
  ScreenshotController _screenshotController = ScreenshotController();
  TextEditingController commentController = TextEditingController();

  void takeScreenshotAndShare(_screenshotController) async {
    final imageFile = await _screenshotController.capture();
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = await File('${directory.path}/image.png').create();
    await imagePath.writeAsBytes(imageFile!);
    await Share.shareFiles([imagePath.path]);
  }

  @override
  void initState() {
    // getCurrentPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget comments(
        String name, String email, String comment, String commentTime) {
      return Container(
        // height: 8.h,?
        width: 90.w,
        child: Column(
          children: [
            SizedBox(height: 1.w),
            Column(
              children: [
                Container(
                  width: 90.w,
                  child: Text(
                    name,
                    // " 4,341",
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  width: 90.w,
                  child: Text(
                    email,
                    // " 4,341",
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.w),
            Container(
              width: 90.w,
              child: Text(
                "Comment: ${comment}",
                // " 4,341",
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 10.sp,
                ),
              ),
            ),
            Container(
              width: 90.w,
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                "${dateWithTimeFormatter.format(DateTime.parse(commentTime))}",
                // " 4,341",
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 8.sp,
                ),
              ),
            ),
            SizedBox(height: 1.w),
            Container(
              width: 90.w,
              height: 0.1.h,
              color: Colors.grey.shade500,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
          child: Container(
            height: 40,
            width: 40,
            // margin: EdgeInsets.only(top: 5.h, bottom: 0, left: 5.w, right: 0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.white, width: 2),
              //  Color(0xff505050),
              // color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Builder(
              builder: (context) => IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 15.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 8.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 3.0,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: TextFormField(
          cursorColor: Colors.white,
          controller: commentController,
          style: TextStyle(color: Colors.black),
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            // contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
            filled: true,
            fillColor: Colors.white,
            hintText: "Write Comment",
            hintStyle: TextStyle(color: Colors.black54, fontSize: 10.sp),
            contentPadding: EdgeInsets.fromLTRB(20, 50, 0, 30),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.white,
                )),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.white,
                // color: Color(0xfff4b41a),
              ),
            ),
            border: InputBorder.none,
            // focusedBorder: InputBorder.none,
            // enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            suffixIcon: InkWell(
              onTap: () {
                print("Post Comment Pressed");
                final userState = BlocProvider.of<UserBloc>(context).state;
                if (userState is UserLoggedIn) {
                  if (commentController.text.isNotEmpty) {
                    BlocProvider.of<ForumBloc>(context).add(CommentAPost(
                        user: userState.user,
                        post: widget.thisPost,
                        comment: commentController.text));
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(showSnackbar("Please add a comment"));
                  }
                }
              },
              child: Icon(
                Icons.send,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBodyBehindAppBar: true,
      body: BlocBuilder<ForumBloc, ForumState>(
        builder: (context, state) {
          if (state is AllPostsRetrieved) {
            Post? currentPost;
            state.posts.forEach((element) {
              if (element.postId == widget.thisPost.postId) {
                currentPost = element;
              }
            });

            return Screenshot(
              controller: _screenshotController,
              child: Container(
                // height: 100.h,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Container(
                            height: 35.h,
                            width: 100.w,
                            child: Image.memory(
                              base64Decode(currentPost!.postImage!),
                              fit: BoxFit.cover,
                            )),
                        Container(
                          child: ListTile(
                            leading: Container(
                              height: 6.h,
                              width: 12.w,
                              decoration: BoxDecoration(
                                color: Color(0xffD3D3D3),
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                    image: MemoryImage(
                                      base64Decode(
                                          currentPost!.user!.userImage!),
                                    ),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            title: Text(
                              currentPost!.user!.userName!,
                              // "Jason Momoa",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  height: 1.4),
                            ),
                            subtitle: Text(
                              "Posted by ${currentPost!.user!.userEmail!}",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.sp,
                                  height: 1.4),
                            ),
                          ),
                        ),
                        Container(
                          height: seenMore ? null : 20.h,
                          width: 90.w,
                          child: Text(
                            currentPost!.postDescription!,
                            // "Lorem Ipsum is simply dummy text of the printing & typesetting industry.",

                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 11.sp,
                                height: 1.6),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              seenMore = !seenMore;
                            });
                          },
                          child: Container(
                            // height: 50.h,
                            width: 90.w,
                            child: Text(
                              seenMore ? "Show less" : "Show more",
                              style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 11.sp,
                                  height: 1.6),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: 5.h, left: 5.w, right: 5.w),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 0.5.sp, color: Colors.grey.shade800),
                              top: BorderSide(
                                  width: 0.5.sp, color: Colors.grey.shade800),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 0, right: 0, bottom: 1.h, top: 1.h),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    final userState =
                                        BlocProvider.of<UserBloc>(context)
                                            .state;

                                    if (userState is UserLoggedIn) {
                                      bool postLikeExists = false;
                                      if (currentPost!.postLikes!.isNotEmpty) {
                                        currentPost!.postLikes!
                                            .forEach((element) {
                                          if (element.userLikeId ==
                                              userState.user.userId) {
                                            postLikeExists = true;
                                          }
                                        });
                                      }
                                      if (!postLikeExists) {
                                        BlocProvider.of<ForumBloc>(context).add(
                                            LikeAPost(
                                                user: userState.user,
                                                post: currentPost!));
                                      } else {
                                        BlocProvider.of<ForumBloc>(context).add(
                                            RemoveLikeFromAPost(
                                                user: userState.user,
                                                post: currentPost!));
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: 3.h,
                                    width: 6.w,
                                    child: Image.asset(
                                      "assets/likeButtonGrey.png",
                                      fit: BoxFit.contain,
                                    ),
                                    // child: Image.asset(
                                    //   "assets/Facebook Like.png",
                                    //   fit: BoxFit.fill,
                                    // )
                                  ),
                                ),
                                Text(
                                  "  ${currentPost!.postLikes!.length.toString()}",
                                  // " 4,341",
                                  style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Icon(
                                  Icons.sms_outlined,
                                  size: 20.sp,
                                  color: Colors.grey.shade800,
                                ),
                                Text(
                                  "  ${currentPost!.postComments!.length.toString()}",
                                  // " 341",
                                  style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                InkWell(
                                  onTap: () {
                                    takeScreenshotAndShare(
                                        _screenshotController);
                                  },
                                  child: Icon(
                                    Icons.share_rounded,
                                    color: Colors.grey.shade800,
                                    size: 20.sp,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Container(
                          width: 90.w,
                          child: Text(
                            "Comments",
                            // " 341",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          width: 90.w,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  currentPost!.postComments!.reversed.map((p) {
                                return comments(
                                    p.commentByUserName!,
                                    p.commentByUserEmail!,
                                    p.postCommentText!,
                                    p.commentTime!);
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                      ],
                    )),
              ),
            );
          } else {
            return Container(
              height: 100.h,
              width: 90.w,
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Color(0xff599E48)),
                  // color: theme.primaryColor,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
