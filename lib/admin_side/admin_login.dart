import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nicotine/Constant.dart';
import 'package:sizer/sizer.dart';
import '../utils/validators.dart';
import 'admin_dashboard.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool obscureShow = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: 100.h,
          width: 100.w,
          color: Colors.white,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  height: 20.h,
                  width: 50.w,
                  // color: Colors.grey,
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/loginqn4l.PNG",
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  child: Text(
                    "Admin Login",
                    style: TextStyle(
                        color: Color(0xff599E48),
                        fontSize: 22.sp,
                        fontFamily: "MaskFilter",
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              height: 3.h,
                              width: 80.w,
                              // color: Colors.purple,
                              child: Text(
                                "Email",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                            Container(
                              // height: 7.h,
                              width: 90.w,
                              // margin: EdgeInsets.symmetric(horizontal: 5.w),
                              // color: Colors.pink,
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
                                style: TextStyle(color: Colors.black),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                // validator: ,
                                decoration: InputDecoration(
                                  // contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 30),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Color(0xff599E48),
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Color(0xff599E48),
                                      // color: Color(0xfff4b41a),
                                    ),
                                  ),
                                  suffixIcon: Icon(
                                    Icons.check,
                                    color: validateStructureEmail(email.text) &&
                                            email.text.isNotEmpty
                                        ? Color(0xff599E48)
                                        : Colors.white,
                                  ),
                                  prefixIcon: Icon(Icons.email_outlined,
                                      color: Color(0xff599E48)),
                                ),
                                onChanged: (value) {
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              height: 3.h,
                              width: 80.w,
                              // color: Colors.purple,
                              child: Text(
                                "Password",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                            Container(
                              // height: 7.h,
                              width: 90.w,
                              // margin: EdgeInsets.only(top: 5.sp),
                              // color: Colors.pink,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Password';
                                  }
                                  if (!validateStructurePassword(value)) {
                                    return "Correct format: Minimum length: 8, at least 1 uppercase, 1 number and 1 special character";
                                  }
                                  return null;
                                },
                                controller: password,
                                style: TextStyle(color: Colors.black),
                                textInputAction: TextInputAction.next,
                                obscureText: obscureShow,
                                decoration: InputDecoration(
                                  errorMaxLines: 2,
                                  // contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 30),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Color(0xff599E48),
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Color(0xff599E48),
                                      // color: Color(0xfff4b41a),
                                    ),
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        obscureShow = !obscureShow;
                                      });
                                    },
                                    child: Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: Color(0xff599E48),
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: Color(0xff599E48),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  height: 7.h,
                  width: 90.w,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kSigninColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        try {
                          FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: email.text, password: password.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminDashboard()));
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
