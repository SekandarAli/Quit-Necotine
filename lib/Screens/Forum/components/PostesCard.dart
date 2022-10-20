import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nicotine/Constant.dart';
import 'package:nicotine/Screens/Components/snackBar.dart';
import 'package:nicotine/blocs/Forum/forum_bloc.dart';
import 'package:nicotine/blocs/User/user_bloc.dart';
import 'package:nicotine/resources/firebase_services/ForumFirestoreService.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:sizer/sizer.dart';

import '../../../models/Post.dart';
import '../../Components/dialog_box_width_button.dart';
import '../post_detail_screen.dart';
import '../upload_post_screen.dart';

class PostesCard extends StatefulWidget {
  final Post thisPost;
  const PostesCard({required this.thisPost, Key? key}) : super(key: key);

  @override
  State<PostesCard> createState() => _PostesCardState();
}

class _PostesCardState extends State<PostesCard> {
  ScreenshotController _screenshotController = ScreenshotController();
  TextEditingController commentController = TextEditingController();
  void takeScreenshotAndShare(_screenshotController) async {
    final imageFile = await _screenshotController.capture();
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = await File('${directory.path}/image.png').create();
    await imagePath.writeAsBytes(imageFile!);
    await Share.shareFiles([imagePath.path]);
  }

  editDialogBox(
      heading, content, void Function() function1, void Function() function2) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 5),
            insetPadding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // IconButton(
                    //     padding: EdgeInsets.zero,
                    //     onPressed:,
                    //     icon: ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // SizedBox(
                        //   width: 10,
                        // ),
                        Text(heading,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            height: 13,
                            // margin: const EdgeInsets.symmetric(vertical: 5),
                            child: Image.asset('assets/crossNoBackground.png'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(content,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                        )),

                    SizedBox(height: 20),
                    Container(
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DialogBoxWidthButton(
                            text: "Edit post",
                            func: function1,
                            isFullWidth: true,
                            isOutlined: false),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DialogBoxWidthButton(
                            text: "Delete post",
                            func: function2,
                            isFullWidth: true,
                            isOutlined: false),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Screenshot(
          controller: _screenshotController,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PostDetailScreen(thisPost: widget.thisPost),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 3.w, right: 3.w, top: 3.h),
              width: 94.w,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Container(
                    // color: Colors.black,
                    // width: 80.w,
                    child: ListTile(
                      leading: Container(
                        height: 6.h,
                        width: 12.w,
                        // margin: EdgeInsets.only(top: 7),
                        decoration: BoxDecoration(
                          color: Color(0xffD3D3D3),
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                              image: MemoryImage(
                                base64Decode(widget.thisPost.user!.userImage!),
                              ),
                              fit: BoxFit.fill),
                        ),
                      ),
                      title: Text(
                        widget.thisPost.user!.userName!,
                        // "Jason Momoa",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            height: 1.4),
                      ),
                      subtitle: Text(
                        "Posted by ${widget.thisPost.user!.userEmail!}",
                        style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w400,
                            fontSize: 10.sp,
                            height: 1.4),
                      ),
                      trailing: (state is UserLoggedIn &&
                                  widget.thisPost.user!.userId ==
                                      state.user.userId ||
                              widget.thisPost.user!.userEmail ==
                                  "admin@nico4life.com")
                          ? GestureDetector(
                              onTap: () {
                                editDialogBox(widget.thisPost.user!.userName!,
                                    widget.thisPost.postDescription!, () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UploadPostScreen(
                                              isEditPost: true,
                                              thisPost: widget.thisPost,
                                            )),
                                  );
                                }, () {
                                  BlocProvider.of<ForumBloc>(context).add(
                                      DeleteAPost(
                                          postId: widget.thisPost.postId!));
                                  Navigator.of(context).pop();
                                });
                              },
                              child: Icon(
                                Icons.more_horiz,
                                size: 24.sp,
                                color: Colors.black,
                              ))
                          : Container(
                              height: 5,
                              width: 5,
                            ),
                    ),
                  ),
                  Container(
                    width: 85.w,
                    child: Text(
                      widget.thisPost.postDescription!,
                      // "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                      style: TextStyle(
                          color: Colors.black, fontSize: 11.sp, height: 1.4),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2.h),
                    height: 22.h,
                    width: 85.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:
                          // Image.network(
                          //   widget.thisPost.postImage!,
                          //   // "assets/Mask.png",
                          //   fit: BoxFit.fill,
                          // ),
                          Image.memory(
                        base64Decode(widget.thisPost.postImage!),
                        // "assets/Mask.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 1.5.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 0.5.sp, color: Colors.grey.shade300),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 5.w, right: 5.w, bottom: 1.h),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              final userState =
                                  BlocProvider.of<UserBloc>(context).state;

                              if (userState is UserLoggedIn) {
                                bool postLikeExists = false;
                                if (widget.thisPost.postLikes!.isNotEmpty) {
                                  widget.thisPost.postLikes!.forEach((element) {
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
                                          post: widget.thisPost));
                                } else {
                                  BlocProvider.of<ForumBloc>(context).add(
                                      RemoveLikeFromAPost(
                                          user: userState.user,
                                          post: widget.thisPost));
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
                              // Image.asset(
                              //   "assets/Facebook Like.png",
                              //   fit: BoxFit.fill,
                              // ),
                            ),
                          ),
                          Text(
                            "  ${widget.thisPost.postLikes!.length.toString()}",
                            // "4,341",
                            style: TextStyle(
                              color: kLightColor,
                              fontSize: 10.sp,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Icon(
                            Icons.sms_outlined,
                            size: 22.sp,
                            color: kLightColor,
                          ),
                          Text(
                            "  ${widget.thisPost.postComments!.length.toString()}",
                            // "341",
                            style: TextStyle(
                              color: kLightColor,
                              fontSize: 10.sp,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          InkWell(
                            onTap: () {
                              takeScreenshotAndShare(_screenshotController);
                            },
                            child: Icon(
                              Icons.share_rounded,
                              color: kLightColor,
                              size: 22.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 5.h,
                    margin: EdgeInsets.only(left: 5.w, bottom: 1.h),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      controller: commentController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "Write Comment",
                        hintStyle:
                            TextStyle(color: Colors.black26, fontSize: 10.sp),
                        // contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 30),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        suffixIcon: InkWell(
                          onTap: () {
                            print("Post Comment Pressed");
                            final userState =
                                BlocProvider.of<UserBloc>(context).state;
                            if (userState is UserLoggedIn) {
                              if (commentController.text.isNotEmpty) {
                                BlocProvider.of<ForumBloc>(context).add(
                                    CommentAPost(
                                        user: userState.user,
                                        post: widget.thisPost,
                                        comment: commentController.text));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    showSnackbar("Please add a comment"));
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
