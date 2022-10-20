
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nicotine/Constant.dart';
import 'package:nicotine/Screens/Components/dialog_box_width_button.dart';
import 'package:nicotine/Screens/Components/snackBar.dart';
import 'package:nicotine/models/Post.dart';
import 'package:nicotine/models/User.dart';
import 'package:sizer/sizer.dart';

import '../../blocs/Forum/forum_bloc.dart';
import '../../blocs/User/user_bloc.dart';
import '../Components/backButton.dart';

class UploadPostScreen extends StatefulWidget {
  bool isEditPost;
  Post? thisPost;
  UploadPostScreen({required this.isEditPost, this.thisPost});

  @override
  State<UploadPostScreen> createState() => _UploadPostScreenState();
}

class _UploadPostScreenState extends State<UploadPostScreen> {
  TextEditingController postDescription = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  PickedFile? _imageFile;
  String? uploadedImage;

  @override
  void initState() {
    super.initState();
    if (widget.isEditPost && widget.thisPost != null) {
      postDescription.text = widget.thisPost!.postDescription!;
      uploadedImage = widget.thisPost!.postImage!;
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> pickImage(ImageSource source) async {
      try {
        // ignore: deprecated_member_use
        final pickedFile = await _picker.getImage(
          source: source,
          maxHeight: 480,
          maxWidth: 640,
          imageQuality: 50,
        );
        setState(() {
          _imageFile = pickedFile;
        });
      } catch (e) {
        print(e.toString());
      }
    }

    Widget selectImageButton(
        String text, IconData icon, ImageSource source, BuildContext context) {
      return Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(5),
          width: 100.w,
          height: 10.h,
          child: ElevatedButton(
            onPressed: () async {
              await pickImage(source);
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            child: SizedBox.expand(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    text,
                  ),
                  Icon(icon, size: 30)
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget cancelButton(BuildContext context) {
      return Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(10),
          width: 100.w,
          height: 10.h,
          child: ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              // foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
            child: Center(
              child: Text(
                'Cancel',
              ),
            ),
          ),
        ),
      );
    }

    Widget uploadimages(BuildContext context) {
      return Container(
        width: 100.w,
        height: 45.h,
        child: Wrap(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Text(
                  'Select a photo',
                  // style: theme.textTheme.headline3,
                ),
              ),
            ),
            Divider(thickness: 2),
            selectImageButton(
                'Take Photo', Icons.camera_alt, ImageSource.camera, context),
            selectImageButton('Choose from Gallery', Icons.image,
                ImageSource.gallery, context),
            cancelButton(context),
          ],
        ),
      );
    }

    imageSelector(
        Function internalSetState, BuildContext context, ThemeData theme) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              //title: new Text("My Super title"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: uploadimages(context),
            );
          });
    }

    Future<File?> testCompressAndGetFile(File file, String targetPath) async {
      print("testCompressAndGetFile");
      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 30,
        minWidth: 1024,
        minHeight: 1024,
        rotate: 0,
      );

      print(file.lengthSync());
      print(result?.lengthSync());
      print("Result Path");
      print("Result Path: " + result!.path.toString());

      return result;
    }

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoggedIn) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              leading: backButton(context),
              backgroundColor: Colors.white,
              title: Text(
                (widget.isEditPost) ? "Edit Post" : "Add Post",
                style: TextStyle(fontSize: 16.sp, color: Colors.black),
              ),
              actions: [
                SizedBox(
                  width: 5.sp,
                ),
              ],
            ),
            floatingActionButton: BlocConsumer<ForumBloc, ForumState>(
              listener: (context, state) {
                if (state is PostAdded) {
                  // BlocProvider.of<ForumBloc>(context).add(GetAllForumPosts());
                }
                if (state is AllPostsRetrieved) {
                  Navigator.of(context).pop();
                }
              },
              builder: (context, state) {
                if ((state is AllPostsRetrieved) || (state is ForumInitial)) {
                  return DialogBoxWidthButton(
                      text: "Upload",
                      func: () async {
                        if (_formKey.currentState!.validate() &&
                            _imageFile != null) {
                          if (widget.isEditPost == false) {
                            final userState =
                                BlocProvider.of<UserBloc>(context).state;
                            if (userState is UserLoggedIn) {
                              final image = File(_imageFile!.path);

                              // File? file = await testCompressAndGetFile(
                              //     image, "assets/image101.jpg");

                              print("creating a post");
                              BlocProvider.of<ForumBloc>(context)
                                  .add(CreateAPost(
                                user: User(

                                    userId: userState.user.userId,
                                    userEmail: userState.user.userEmail,
                                    userName: userState.user.userName,
                                    userPassword: userState.user.userPassword,
                                    userImage: userState.user.userImage,
                                    userPoints: userState.user.userPoints,
                                    userMistakes: userState.user.userMistakes,
                                    userQuestionsAsked:
                                        userState.user.userQuestionsAsked),
                                postDescription: postDescription.text,
                                postImage: _imageFile!.path,
                              ));
                            }
                          } else {
                            final userState =
                                BlocProvider.of<UserBloc>(context).state;
                            if (userState is UserLoggedIn) {
                              print("editing a post");
                              BlocProvider.of<ForumBloc>(context).add(EditAPost(
                                user: User(
                                    userId: userState.user.userId,
                                    userEmail: userState.user.userEmail,
                                    userName: userState.user.userName,
                                    userPassword: userState.user.userPassword,
                                    userImage: userState.user.userImage,
                                    userPoints: userState.user.userPoints,
                                    userMistakes: userState.user.userMistakes,
                                    userQuestionsAsked:
                                        userState.user.userQuestionsAsked),
                                post: widget.thisPost!,
                                postDescription: postDescription.text,
                                postImage: _imageFile!.path,
                              ));
                            }
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(showSnackbar(
                              "Some field is left empty or image is not added"));
                        }
                      },
                      isFullWidth: true,
                      isOutlined: false);
                } else {
                  return Container(
                    height: 70.h,
                    width: 90.w,
                    color: Colors.white,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Color(0xff599E48)),
                        // color: theme.primaryColor,
                      ),
                    ),
                  );
                }
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: Container(
              margin: EdgeInsets.only(left: 3.w, right: 3.w, top: 3.h),
              width: 94.w,
              height: 50.h,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Form(
                key: _formKey,
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
                                image: NetworkImage(state.user.userImage!),
                                fit: BoxFit.fill),
                          ),
                        ),
                        title: Text(
                          state.user.userName!,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              height: 1.4),
                        ),
                        subtitle: Text(
                          "Posted by ${state.user.userEmail!}",
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.w400,
                              fontSize: 10.sp,
                              height: 1.4),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return new AlertDialog(
                                //title: new Text("My Super title"),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                content: uploadimages(context),
                              );
                            });
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 2.h),
                        height: 22.h,
                        width: 85.w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: _imageFile != null
                                ? Image.file(
                                    File(_imageFile?.path ?? ''),
                                    fit: BoxFit.cover,
                                    // width: size.width * 0.2,
                                  )
                                : uploadedImage != null
                                    ? Image.memory(
                                        base64Decode(uploadedImage!),
                                        // "assets/Mask.png",
                                        fit: BoxFit.contain,
                                      )
                                    : Icon(
                                        Icons.add,
                                        size: 40,
                                        color: Colors.black,
                                      )
                            // child: Image.network(
                            //   widget.thisPost.postImage!,
                            //   // "assets/Mask.png",
                            //   fit: BoxFit.fill,
                            // ),
                            ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      // height: 7.h,
                      width: 85.w,
                      // margin: EdgeInsets.only(top: 5.sp),
                      // color: Colors.pink,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter description';
                          }
                          if (value.length < 4) {
                            return 'Please enter more in the post description';
                          }
                          return null;
                        },
                        maxLines: 3,
                        controller: postDescription,
                        style: TextStyle(color: Colors.black),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        // validator: ,
                        decoration: InputDecoration(
                          // contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 30),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          prefixIcon: Icon(
                            Icons.description,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    // adddesc
                    // Container(
                    //   width: 85.w,
                    //   child: Text(
                    //     widget.thisPost.postDescription!,
                    //     // "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    //     style: TextStyle(
                    //         color: Colors.black, fontSize: 11.sp, height: 1.4),
                    //   ),
                    // ),
                    //addimage
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container(
            height: 50.h,
            child: Center(
              child: Text(
                "Login to edit or add post",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
