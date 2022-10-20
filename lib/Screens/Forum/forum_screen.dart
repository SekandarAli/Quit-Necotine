import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nicotine/Constant.dart';
import 'package:nicotine/Screens/Components/backButton.dart';
import 'package:nicotine/Screens/Components/dialog_box.dart';
import 'package:nicotine/Screens/Forum/upload_post_screen.dart';
import 'package:sizer/sizer.dart';

import '../../blocs/Forum/forum_bloc.dart';
import '../../blocs/User/user_bloc.dart';

import 'components/PostesCard.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({Key? key}) : super(key: key);

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllPosts();
  }

  getAllPosts() {
    BlocProvider.of<ForumBloc>(context).add(GetAllForumPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: backButton(context),
        // Padding(
        //   padding: EdgeInsets.only(left: 5.sp),
        //   child: Container(
        //     margin: EdgeInsets.only(
        //         top: 1.4.h, bottom: 1.4.h, left: 2.w, right: 2.w),
        //     decoration: BoxDecoration(
        //       color: Colors.white.withOpacity(0.1),
        //       borderRadius: BorderRadius.circular(50),
        //     ),
        //     child: Builder(
        //       builder: (context) => IconButton(
        //         onPressed: () => Navigator.pop(context),
        //         icon: Icon(
        //           Icons.arrow_back_ios_rounded,
        //           size: 12.sp,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        backgroundColor: Colors.white,
        title: Text(
          "Forum",
          style: TextStyle(fontSize: 16.sp, color: Colors.black),
        ),
        actions: [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, userState) {
              if (userState is UserLoggedIn
                  //  &&
                  //     userState.user.userEmail == "admin@nico4life.com"
                  ) {
                return GestureDetector(
                    onTap: () {
                      learnMoreDialogBox(
                        context: context,
                        heading: 'Create a Post',
                        content: 'Do you want to create a post?',
                        buttonText: 'Create a post',
                        function: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UploadPostScreen(
                                      isEditPost: false,
                                    )),
                          );

                          // final userState =
                          //     BlocProvider.of<UserBloc>(context).state;
                          // if (userState is UserLoggedIn) {
                          //   print("creating a post");
                          //   BlocProvider.of<ForumBloc>(context).add(CreateAPost(
                          //     user: User(
                          //         userId: userState.user.userId,
                          //         userEmail: userState.user.userEmail,
                          //         userName: userState.user.userName,
                          //         userPassword: userState.user.userPassword,
                          //         userImage: userState.user.userImage,
                          //         userPoints: userState.user.userPoints,
                          //         userMistakes: userState.user.userMistakes,
                          //         userQuestionsAsked:
                          //             userState.user.userQuestionsAsked),
                          //     postDescription: "Welcome",
                          //     postImage:
                          //         "https://images.unsplash.com/photo-1592743263126-bb241ee76ac7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YmVhdXRpZnVsJTIwc2NlbmVyeXxlbnwwfHwwfHw%3D&w=1000&q=80",
                          //   ));
                          //   // "https://images.unsplash.com/photo-1592743263126-bb241ee76ac7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YmVhdXRpZnVsJTIwc2NlbmVyeXxlbnwwfHwwfHw%3D&w=1000&q=80"));
                        },
                      );
                      //   Navigator.of(context).pop();
                      // } else {
                      //   Navigator.of(context).pop();
                      //   ScaffoldMessenger.of(context)
                      //       .showSnackBar(showSnackbar("Please login to post"));
                      // }
                    },
                    child: Icon(
                      Icons.more_horiz,
                      size: 24.sp,
                      color: Colors.black,
                    ));
              } else {
                return Container();
              }
            },
          ),
          SizedBox(
            width: 5.sp,
          ),
        ],
      ),
      body: BlocConsumer<ForumBloc, ForumState>(
        listener: (context, state) {
          if (state is PostAdded) {
            getAllPosts();
          }
        },
        builder: (context, state) {
          if (state is AllPostsRetrieved) {
            if (state.posts.length > 0) {
              return Container(
                height: 100.h,
                width: 100.w,
                color: Colors.white,
                child: ListView.builder(
                    itemCount: state.posts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => ShopPayment()),);
                        },
                        child: PostesCard(
                          thisPost: state.posts[index],
                        ),
                      );
                    }),
              );
            } else {
              return Container(
                height: 50.h,
                child: Center(
                  child: Text(
                    "No post has been added yet",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            }
          } else {
            return Container(
              height: 60.h,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(kLightColor),
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
