
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nicotine/Constant.dart';
import 'package:nicotine/Screens/auth_screens/signup_screen.dart';
import 'package:nicotine/admin_side/admin_login.dart';
import 'package:nicotine/blocs/User/user_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../resources/firebase_services/auth_methods.dart';
import '../../utils/validators.dart';
import '../Components/icon_button.dart';
import '../Home Screens/dash_bord.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool obscureShow = true;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "LOGIN",
                  style: TextStyle(
                      color: kSigninColor,
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
                    Column(
                      children: [
                        SizedBox(
                          height: 3.h,
                          width: 80.w,
                          // color: Colors.purple,
                          child: const Text(
                            "Email",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                        SizedBox(
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
                            style: TextStyle(color: Colors.black),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            // validator: ,
                            decoration: InputDecoration(
                              // contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 30),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: kSigninColor,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: kSigninColor,
                                  // color: Color(0xfff4b41a),
                                ),
                              ),
                              suffixIcon: Icon(
                                Icons.check,
                                color: validateStructureEmail(email.text) &&
                                    email.text.isNotEmpty
                                    ? kSigninColor
                                    : Colors.white,
                              ),
                              prefixIcon: const Icon(Icons.email_outlined,
                                  color: kSigninColor),
                            ),
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                      ],
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
                                      color: kSigninColor,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: kSigninColor,
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
                                    color: kSigninColor,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: kSigninColor,
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
              BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is UserLoggedIn) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => DashBord()));
                  }
                },
                builder: (context, state) {
                  if (!(state is UserLoading)) {
                    return _isLoading?CircularProgressIndicator(color: kSigninColor,):Container(
                              height: 8.h,
                              width: 90.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: ElevatedButton(child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16.sp),),onPressed: (){



            if (_formKey.currentState!.validate()) {
                  setState(() {
                    _isLoading= true;
                  });
                 AuthMethods().loginUser(email: email.text, password: password.text).then((value) {

                   if(value=="success"){
                     setState(() {
                       _isLoading= false;
                     });

                     Navigator.of(context).push(
                         MaterialPageRoute(builder: (context) => DashBord()));
                   }
                 });
                }

                              },style: ButtonStyle(   backgroundColor: MaterialStateProperty.all(kSigninColor),shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          ) ),

                              ),

                            )
                            );
                  } else {
                    return Container(
                      height: 7.h,
                      width: 90.w,
                      color: Colors.white,
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                          AlwaysStoppedAnimation<Color>(kSigninColor),
                          // color: theme.primaryColor,
                        ),
                      ),
                    );
                  }
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 3.h),
                child: Text(
                  "Or Login with",
                  style: TextStyle(color: Colors.black, fontSize: 14.sp),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomButton(
                  btnText: "Google",
                  icnString: googleIcon,
                  ptr: () {
                    // BlocProvider.of<UserBloc>(context).add(GoogleLogin());
                  }, clr: kSigninColor,),
              SizedBox(
                height: 2.h,
              ),
              CustomButton(
                  btnText: "Facbook",
                  icnString: facbookIcon,
                  ptr: () {
                    // BlocProvider.of<UserBloc>(context).add(FacebookLogin());
                  }, clr: kSigninColor,),
              SizedBox(
                height: 3.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignupScreen()));
                      // MaterialPageRoute(builder: (context) => AdminLoginScreen()));
                },
                child: RichText(
                  text: TextSpan(
                    text: 'If you don’t have an account? ',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    children: [
                      TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: kSigninColor)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
