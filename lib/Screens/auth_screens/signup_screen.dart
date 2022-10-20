import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nicotine/Screens/Components/snackBar.dart';
import 'package:sizer/sizer.dart';
import '../../Constant.dart';
import '../../blocs/User/user_bloc.dart';
import '../../resources/firebase_services/auth_methods.dart';
import '../../utils/validators.dart';
import '../Components/icon_button.dart';
import '../Home Screens/dash_bord.dart';
import '../discription_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isLoading = false;
  bool obscureShow = true;
  final _formKey = GlobalKey<FormState>();

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
                height: 18.h,
                width: 40.w,
                // color: Colors.grey,
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/signupqn4l.PNG",
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 1.h,),
              Container(
                child: Text(
                  "Create Account",
                  style: TextStyle(
                      color: kSignupColor,
                      fontSize: 22.sp,
                      fontFamily: "MaskFilter",
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 1.h,
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
                              "Your name",
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
                                  return 'Please enter name';
                                }
                                if (value.length < 4) {
                                  return 'Please enter a valid full name';
                                }
                                return null;
                              },
                              controller: name,
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
                                  borderSide: BorderSide(color: kSignupColor),
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: kSignupColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            height: 3.h,
                            width: 80.w,
                            // color: Colors.purple,
                            child: Text(
                              "Your email",
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
                                  borderSide: BorderSide(color: kSignupColor),
                                ),
                                suffixIcon: Icon(
                                  Icons.check,
                                  color: validateStructureEmail(email.text) &&
                                          email.text.isNotEmpty
                                      ? kSignupColor
                                      : Colors.white,
                                ),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: kSignupColor,
                                ),
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
                      height: 2.h,
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
                                      color: kSignupColor,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: kSignupColor,
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
                                    color: kSignupColor,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: kSignupColor,
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
                  if (state is UserShowQuestions) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DiscriptionScreen()));
                  }
                  if (state is LogInError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(showSnackbar(state.error.toString()));
                    BlocProvider.of<UserBloc>(context).add(InitialStatePush());
                  }
                  if (state is UserLoggedIn) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => DashBord()));
                  }
                },
                builder: (context, state) {
                  if (!(state is UserLoading)) {
                    /////
                    return _isLoading
                        ? CircularProgressIndicator(
                            color: kSignupColor,
                          )
                        : Container(
                            height: 8.h,
                            width: 90.w,
                            decoration: BoxDecoration(
                                color: kSignupColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: ElevatedButton(
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(10)),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(kSignupColor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  AuthMethods()
                                      .signUpUser(
                                          username: name.text,
                                          email: email.text,
                                          password: password.text)
                                      .then((value) {
                                    if (value == "ERROR_EMAIL_ALREADY_IN_USE") {
                                      print("Email already exist");
                                    } else if (value == "success") {
                                      setState(() {
                                        _isLoading = false;
                                      });

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DashBord(),
                                        ),
                                      );
                                    } else {
                                      showSnackbar(value.toString());
                                    }
                                  });
                                  // BlocProvider.of<UserBloc>(context).add(SignUp(
                                  //     email: email.text,
                                  //     fullName: name.text,
                                  //     password: password.text));
                                } else {
                                  print("Error in Validation");
                                }
                              },
                              child: Text(
                                "Create Account",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp),
                              ),
                            ),
                          );
                  } else {
                    return Container(
                      height: 7.h,
                      width: 90.w,
                      color: Colors.white,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(kSignupColor),
                          // color: theme.primaryColor,
                        ),
                      ),
                    );
                  }
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 2.h),
                child: Text(
                  "Or Sign Up with",
                  style: TextStyle(color: Colors.black, fontSize: 12.sp),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              CustomButton(
                  clr: kSignupColor,
                  btnText: "Google",
                  icnString: googleIcon,
                  ptr: () {
                    // BlocProvider.of<UserBloc>(context).add(GoogleLogin());
                  }),
              SizedBox(
                height: 2.h,
              ),
              CustomButton(
                  clr: kSignupColor,
                  btnText: "Facebook",
                  icnString: facbookIcon,
                  ptr: () {
                    // BlocProvider.of<UserBloc>(context).add(FacebookLogin());
                  }),
              SizedBox(
                height: 2.h,
              ),

              SizedBox(
                height: 2.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: RichText(
                  text: const TextSpan(
                    text: 'You have an account? ',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    children: [
                      TextSpan(
                          text: 'Login',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: kSignupColor)),
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
