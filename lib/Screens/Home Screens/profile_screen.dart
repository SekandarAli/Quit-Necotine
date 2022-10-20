// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:nicotine/Constant.dart';
// import 'package:nicotine/Screens/auth_screens/login_screen.dart';
// import 'package:nicotine/blocs/Activity/activity_bloc.dart';
// import 'package:nicotine/blocs/Goal/goal_bloc.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../blocs/Forum/forum_bloc.dart';
// import '../../blocs/User/user_bloc.dart';
// import '../../resources/firebase_services/auth_methods.dart';
// import '../../utils/validators.dart';
// import '../Components/backButton.dart';
//
// class ProfileScreen extends StatefulWidget {
//   bool fromDrawer;
//
//   ProfileScreen({
//     required this.fromDrawer,
//   });
//
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   TextEditingController name = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController password = TextEditingController();
//   TextEditingController mistake = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   final ImagePicker _picker = ImagePicker();
//   PickedFile? _imageFile;
//   String? uploadedImage;
//   @override
//   void initState() {
//     super.initState();
//     final userState = BlocProvider.of<UserBloc>(context).state;
//     if (userState is UserLoggedIn) {
//       name.text = userState.user.userName!;
//       email.text = userState.user.userEmail!;
//       password.text = userState.user.userPassword!;
//       if (userState.user.userImage! !=
//           "http://4.bp.blogspot.com/-zsbDeAUd8aY/US7F0ta5d9I/AAAAAAAAEKY/UL2AAhHj6J8/s1600/facebook-default-no-profile-pic.jpg") {
//         uploadedImage = userState.user.userImage;
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Future<void> pickImage(ImageSource source) async {
//       try {
//         // ignore: deprecated_member_use
//         final pickedFile = await _picker.getImage(
//           source: source,
//           maxHeight: 480,
//           maxWidth: 640,
//           imageQuality: 50,
//         );
//         setState(() {
//           _imageFile = pickedFile;
//         });
//       } catch (e) {
//         print(e.toString());
//       }
//     }
//
//     Widget selectImageButton(
//         String text, IconData icon, ImageSource source, BuildContext context) {
//       return Center(
//         child: Container(
//           margin: const EdgeInsets.symmetric(vertical: 5),
//           padding: const EdgeInsets.all(5),
//           width: 100.w,
//           height: 10.h,
//           child: ElevatedButton(
//             onPressed: () async {
//               await pickImage(source);
//               Navigator.of(context).pop();
//             },
//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
//               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                 RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//             ),
//             child: SizedBox.expand(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Text(
//                     text,
//                   ),
//                   Icon(icon, size: 30)
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     }
//
//     Widget cancelButton(BuildContext context) {
//       return Center(
//         child: Container(
//           margin: const EdgeInsets.symmetric(vertical: 5),
//           padding: const EdgeInsets.all(10),
//           width: 100.w,
//           height: 10.h,
//           child: ElevatedButton(
//             onPressed: () async {
//               Navigator.of(context).pop();
//             },
//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
//               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                 RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//               // foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
//             ),
//             child: Center(
//               child: Text(
//                 'Cancel',
//               ),
//             ),
//           ),
//         ),
//       );
//     }
//
//     Widget uploadimages(BuildContext context) {
//       return Container(
//         width: 100.w,
//         height: 45.h,
//         child: Wrap(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               child: Center(
//                 child: Text(
//                   'Select a photo',
//                   // style: theme.textTheme.headline3,
//                 ),
//               ),
//             ),
//             Divider(thickness: 2),
//             selectImageButton(
//                 'Take Photo', Icons.camera_alt, ImageSource.camera, context),
//             selectImageButton('Choose from Gallery', Icons.image,
//                 ImageSource.gallery, context),
//             cancelButton(context),
//           ],
//         ),
//       );
//     }
//
//     return  BlocProvider(
//
//         create: (context) => UserBloc()..add(CheckIfLoggedIn()),
//
//     child:  Scaffold(
//       appBar: ((widget.fromDrawer))
//           ? AppBar(
//               centerTitle: true,
//               elevation: 0,
//               leading: backButton(context),
//               backgroundColor: Colors.white,
//               title: Text(
//                 "Profile",
//                 style: TextStyle(fontSize: 16.sp, color: Colors.black),
//               ),
//               actions: [],
//             )
//           : null,
//       body: BlocConsumer<UserBloc, UserState>(
//         listener: (context, state) {
//           if (state is UserInitial) {
//             Navigator.pushReplacement(context,
//                 MaterialPageRoute(builder: (context) => LoginScreen()));
//           }
//         },
//         builder: (context, state) {
//           if (state is UserLoggedIn) {
//             return Container(
//               height: 120.h,
//               width: 100.w,
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 child: Material(
//                   child: Container(
//                     color: Colors.white,
//                     height: 110.h,
//                     width: 100.w,
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 2.h,
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               showDialog(
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     return new AlertDialog(
//                                       //title: new Text("My Super title"),
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(10.0))),
//                                       content: uploadimages(context),
//                                     );
//                                   });
//                             },
//                             child: Container(
//                               // margin: EdgeInsets.only(top: 2.h),
//                               height: 13.h,
//                               width: 26.w,
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border: Border.all(color: Colors.black),
//                                   borderRadius: BorderRadius.circular(50)),
//                               child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(50),
//                                   child: _imageFile != null
//                                       ? Image.file(
//                                           File(_imageFile?.path ?? ''),
//                                           fit: BoxFit.cover,
//                                           // width: size.width * 0.2,
//                                         )
//                                       : uploadedImage != null
//                                           ? Image.memory(
//                                               base64Decode(uploadedImage!),
//                                               // "assets/Mask.png",
//                                               fit: BoxFit.cover,
//                                             )
//                                           : Image.network(
//                                               "http://4.bp.blogspot.com/-zsbDeAUd8aY/US7F0ta5d9I/AAAAAAAAEKY/UL2AAhHj6J8/s1600/facebook-default-no-profile-pic.jpg",
//                                               fit: BoxFit.cover,
//                                             )
//                                   // child: Image.network(
//                                   //   widget.thisPost.postImage!,
//                                   //   // "assets/Mask.png",
//                                   //   fit: BoxFit.fill,
//                                   // ),
//                                   ),
//                             ),
//                           ),
//                           // Container(
//                           //   height: 10.h,
//                           //   width: 20.w,
//                           //   decoration: BoxDecoration(
//                           //       borderRadius: BorderRadius.circular(50),
//                           //       color: Colors.grey[300]),
//                           //   child: ClipRRect(
//                           //       borderRadius: BorderRadius.circular(50),
//                           //       child: Image.network(state.user.userImage!)
//                           //       // Image.asset("assets/profile.png")
//                           //       ),
//                           // ),
//                           Text(
//                             state.user.userName!,
//                             // "Hassannew",
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 14.sp,
//                                 height: 2),
//                           ),
//                           Text(
//                             "${state.user.userPoints.toString()} Points",
//                             // "0 Points",
//                             style: TextStyle(
//                                 color: kSignupColor,
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 11.sp,
//                                 height: 1),
//                           ),
//                           SizedBox(
//                             height: 2.h,
//                           ),
//                           Container(
//                             height: 5.h,
//                             width: 35.w,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5)),
//                           ),
//                           SizedBox(
//                             height: 2.h,
//                           ),
//                           Container(
//                             // height: 10.h,
//                             width: 90.w,
//                             child: TextFormField(
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter name';
//                                 }
//                                 return null;
//                               },
//                               controller: name,
//                               cursorColor: Colors.black,
//                               style: TextStyle(color: Colors.black),
//                               textInputAction: TextInputAction.next,
//                               keyboardType: TextInputType.emailAddress,
//                               // validator: ,
//
//                               decoration: InputDecoration(
//                                 prefixIcon: Padding(
//                                   padding: const EdgeInsets.all(15.0),
//                                   child: Container(
//                                       height: 5.5.h,
//                                       width: 11.w,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           color: Colors.red.withOpacity(0.2)),
//                                       child: Icon(
//                                         Icons.person_outline_rounded,
//                                         color: kSignupColor,
//                                         size: 20.sp,
//                                       )),
//                                 ),
//                                 contentPadding:
//                                     EdgeInsets.fromLTRB(20, 0, 0, 0),
//                                 focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: BorderSide(
//                                       color: Colors.black,
//                                     )),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: BorderSide(
//                                     color: Colors.black,
//                                     width: 0.5.sp,
//                                   ),
//                                 ),
//                                 disabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: BorderSide(
//                                       color: Colors.black,
//                                     )),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 2.h,
//                           ),
//                           Container(
//                             // height: 10.h,
//                             width: 90.w,
//                             child: TextFormField(
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter Email';
//                                 }
//                                 if (!validateStructureEmail(value)) {
//                                   return "Please enter an email with correct format";
//                                 }
//                                 return null;
//                               },
//                               controller: email,
//                               cursorColor: Colors.black,
//                               style: TextStyle(color: Colors.black),
//                               textInputAction: TextInputAction.next,
//                               keyboardType: TextInputType.emailAddress,
//                               // validator: ,
//
//                               decoration: InputDecoration(
//                                 prefixIcon: Padding(
//                                   padding: const EdgeInsets.all(15.0),
//                                   child: Container(
//                                       height: 5.5.h,
//                                       width: 11.w,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           color: Colors.red.withOpacity(0.2)),
//                                       child: Icon(
//                                         Icons.email_outlined,
//                                         color: kSignupColor,
//                                         size: 20.sp,
//                                       )),
//                                 ),
//                                 suffixIcon: Icon(
//                                   Icons.check,
//                                   color: validateStructureEmail(email.text) &&
//                                           email.text.isNotEmpty
//                                       ? Colors.black
//                                       : Colors.white,
//                                 ),
//                                 contentPadding:
//                                     EdgeInsets.fromLTRB(20, 0, 0, 0),
//                                 focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: BorderSide(
//                                       color: Colors.black,
//                                     )),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: BorderSide(
//                                     color: Colors.black,
//                                     width: 0.5.sp,
//                                   ),
//                                 ),
//                                 disabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: BorderSide(
//                                       color: Colors.black,
//                                     )),
//                               ),
//                               onChanged: (value) {
//                                 setState(() {});
//                               },
//                             ),
//                           ),
//                           SizedBox(
//                             height: 2.h,
//                           ),
//                           Container(
//                             // height: 10.h,
//                             width: 90.w,
//                             child: TextFormField(
//                               enabled: false,
//                               obscureText: true,
//
//                               controller: password,
//                               cursorColor: Colors.black,
//                               style: TextStyle(color: Colors.black),
//                               textInputAction: TextInputAction.next,
//                               keyboardType: TextInputType.emailAddress,
//                               // validator: ,
//
//                               decoration: InputDecoration(
//                                 prefixIcon: Padding(
//                                   padding: const EdgeInsets.all(15.0),
//                                   child: Container(
//                                       height: 5.5.h,
//                                       width: 11.w,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           color: Colors.red.withOpacity(0.2)),
//                                       child: Icon(
//                                         Icons.lock_outline,
//                                         color: kSignupColor,
//                                         size: 20.sp,
//                                       )),
//                                 ),
//                                 contentPadding:
//                                     EdgeInsets.fromLTRB(20, 0, 0, 0),
//                                 focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: BorderSide(
//                                       color: Colors.black,
//                                     )),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: BorderSide(
//                                     color: Colors.black,
//                                     width: 0.5.sp,
//                                   ),
//                                 ),
//                                 disabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: BorderSide(
//                                       color: Colors.black,
//                                     )),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 2.h,
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(
//                               top: 2.h,
//                             ),
//                             width: 90.w,
//                             child: Text(
//                               "My Mistakes",
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 15.sp,
//                                   fontWeight: FontWeight.w400),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 2.h,
//                           ),
//                           Container(
//                             // height: 10.h,
//                             width: 90.w,
//                             child: TextFormField(
//                               controller: mistake,
//                               cursorColor: Colors.black,
//                               style: TextStyle(color: Colors.black),
//                               textInputAction: TextInputAction.next,
//                               keyboardType: TextInputType.emailAddress,
//                               // validator: ,
//                               maxLines: 5,
//                               decoration: InputDecoration(
//                                 contentPadding:
//                                     EdgeInsets.fromLTRB(20, 20, 20, 20),
//                                 focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: BorderSide(
//                                       color: Colors.black,
//                                     )),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: BorderSide(
//                                     color: Colors.black,
//                                     width: 0.5.sp,
//                                   ),
//                                 ),
//                                 disabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: BorderSide(
//                                       color: Colors.black,
//                                     )),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 2.h,
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               BlocProvider.of<ForumBloc>(context)
//                                   .add(ResetForumState());
//
//                               BlocProvider.of<ActivityBloc>(context)
//                                   .add(ResetActivityState());
//                               BlocProvider.of<GoalBloc>(context)
//                                   .add(ResetGoalState());
//                               BlocProvider.of<UserBloc>(context).add(Logout());
//                             },
//                             child: Container(
//                               margin: EdgeInsets.only(top: 2.h),
//                               width: 90.w,
//                               height: 8.h,
//                               decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.black),
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: Center(
//                                 child: ListTile(
//                                   onTap: (){
//       AuthMethods().signOut().then((value) {
//
//     if(value=="success"){
//     Navigator.pushReplacement(context,
//     MaterialPageRoute(builder: (context) => LoginScreen()));
//     }  else{
//
//     }
//     });
//
//
//                                   },
//                                   leading: Container(
//                                       height: 5.5.h,
//                                       width: 11.w,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           color: Colors.red.withOpacity(0.2)),
//                                       child: Icon(
//                                         Icons.logout,
//                                         color: kSignupColor,
//                                         size: 20.sp,
//                                       )),
//                                   title: Text(
//                                     "Logout",
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 13.sp,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                   trailing: Icon(
//                                     Icons.arrow_forward_ios,
//                                     color: Colors.black26,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           } else {
//             return Container();
//           }
//         },
//       ),
//     ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nicotine/Constant.dart';
import 'package:nicotine/Screens/auth_screens/login_screen.dart';
import 'package:nicotine/blocs/Activity/activity_bloc.dart';
import 'package:nicotine/blocs/Goal/goal_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../blocs/Forum/forum_bloc.dart';
import '../../blocs/User/user_bloc.dart';
import '../../resources/firebase_services/auth_methods.dart';
import '../../utils/validators.dart';
import '../Components/backButton.dart';

class ProfileScreen extends StatefulWidget {
  bool fromDrawer;

  ProfileScreen({
    required this.fromDrawer,
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController mistake = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  PickedFile? _imageFile;
  String? uploadedImage;

  @override
  void initState() {
    super.initState();
    final userState = BlocProvider.of<UserBloc>(context).state;
    if (userState is UserLoggedIn) {
      name.text = userState.user.userName!;
      email.text = userState.user.userEmail!;
      password.text = userState.user.userPassword!;
      if (userState.user.userImage! !=
          "http://4.bp.blogspot.com/-zsbDeAUd8aY/US7F0ta5d9I/AAAAAAAAEKY/UL2AAhHj6J8/s1600/facebook-default-no-profile-pic.jpg") {
        uploadedImage = userState.user.userImage;
      }
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

    return Scaffold(
      appBar: ((widget.fromDrawer))
          ? AppBar(
              centerTitle: true,
              elevation: 0,
              leading: backButton(context),
              backgroundColor: Colors.white,
              title: Text(
                "Profile",
                style: TextStyle(fontSize: 16.sp, color: Colors.black),
              ),
              actions: [],
            )
          : null,
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserInitial) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          }
        },
        builder: (context, state) {
          if (state is UserLoggedIn) {
            return Container(
              height: 120.h,
              width: 100.w,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Material(
                  child: Container(
                    color: Colors.white,
                    height: 110.h,
                    width: 100.w,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 2.h,
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
                              // margin: EdgeInsets.only(top: 2.h),
                              height: 13.h,
                              width: 26.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(50)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
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
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              "http://4.bp.blogspot.com/-zsbDeAUd8aY/US7F0ta5d9I/AAAAAAAAEKY/UL2AAhHj6J8/s1600/facebook-default-no-profile-pic.jpg",
                                              fit: BoxFit.cover,
                                            )
                                  // child: Image.network(
                                  //   widget.thisPost.postImage!,
                                  //   // "assets/Mask.png",
                                  //   fit: BoxFit.fill,
                                  // ),
                                  ),
                            ),
                          ),
                          // Container(
                          //   height: 10.h,
                          //   width: 20.w,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(50),
                          //       color: Colors.grey[300]),
                          //   child: ClipRRect(
                          //       borderRadius: BorderRadius.circular(50),
                          //       child: Image.network(state.user.userImage!)
                          //       // Image.asset("assets/profile.png")
                          //       ),
                          // ),
                          Text(
                            state.user.userName!,
                            // "Hassannew",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                height: 2),
                          ),
                          Text(
                            "${state.user.userPoints.toString()} Points",
                            // "0 Points",
                            style: TextStyle(
                                color: kSignupColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 11.sp,
                                height: 1),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            height: 5.h,
                            width: 35.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            // height: 10.h,
                            width: 90.w,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter name';
                                }
                                return null;
                              },
                              controller: name,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              // validator: ,

                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                      height: 5.5.h,
                                      width: 11.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.red.withOpacity(0.2)),
                                      child: Icon(
                                        Icons.person_outline_rounded,
                                        color: kSignupColor,
                                        size: 20.sp,
                                      )),
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 0, 0, 0),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 0.5.sp,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            // height: 10.h,
                            width: 90.w,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Email';
                                }
                                if (!validateStructureEmail(value)) {
                                  return "Please enter an email with correct format";
                                }
                                return null;
                              },
                              controller: email,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              // validator: ,

                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                      height: 5.5.h,
                                      width: 11.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.red.withOpacity(0.2)),
                                      child: Icon(
                                        Icons.email_outlined,
                                        color: kSignupColor,
                                        size: 20.sp,
                                      )),
                                ),
                                suffixIcon: Icon(
                                  Icons.check,
                                  color: validateStructureEmail(email.text) &&
                                          email.text.isNotEmpty
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 0, 0, 0),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 0.5.sp,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                              ),
                              onChanged: (value) {
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            // height: 10.h,
                            width: 90.w,
                            child: TextFormField(
                              enabled: false,
                              obscureText: true,

                              controller: password,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              // validator: ,

                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                      height: 5.5.h,
                                      width: 11.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.red.withOpacity(0.2)),
                                      child: Icon(
                                        Icons.lock_outline,
                                        color: kSignupColor,
                                        size: 20.sp,
                                      )),
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 0, 0, 0),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 0.5.sp,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 2.h,
                            ),
                            width: 90.w,
                            child: Text(
                              "My Mistakes",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            // height: 10.h,
                            width: 90.w,
                            child: TextFormField(
                              controller: mistake,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              // validator: ,
                              maxLines: 5,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 20, 20, 20),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 0.5.sp,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<ForumBloc>(context)
                                  .add(ResetForumState());

                              BlocProvider.of<ActivityBloc>(context)
                                  .add(ResetActivityState());
                              BlocProvider.of<GoalBloc>(context)
                                  .add(ResetGoalState());
                              BlocProvider.of<UserBloc>(context).add(Logout());
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 2.h),
                              width: 90.w,
                              height: 8.h,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: ListTile(
                                  onTap: () {
                                    AuthMethods().signOut().then((value) {
                                      if (value == "success") {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen()));
                                      } else {}
                                    });
                                  },
                                  leading: Container(
                                      height: 5.5.h,
                                      width: 11.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.red.withOpacity(0.2)),
                                      child: Icon(
                                        Icons.logout,
                                        color: kSignupColor,
                                        size: 20.sp,
                                      )),
                                  title: Text(
                                    "Logout",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black26,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
