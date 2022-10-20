import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nicotine/Constant.dart';
import 'package:sizer/sizer.dart';

import 'Questionnaire/questionnaire_screen.dart';

class DiscriptionScreen extends StatelessWidget {
  const DiscriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const QuestionnaireScreen(),
            ),
          );
        },
        child: Container(
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
                  width: 35.w,
                  // color: Colors.grey,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 2.h, left: 3.w),
                        child: Image.asset(
                          "assets/loginqn4l.PNG",
                          fit: BoxFit.fill,
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.sp),
                  child: Text(
                    "Out with the old and in with the new.\nThe brand new way to Let your nicotine addiction go. It’s a unique Solution that can take 120 days to reduce the nicotine you smoke by 100%. This is a solution to your nicotine cravings. It’s an on line programme for those who want to give up smoking nicotine, but feel the need to continue to smoke until they are ready to let go. There’s no need to go cold Turkey. There’s no need to feel anxious, or depressed at the thought of losing your best friend. QN4L is a brand new habit. It’s a lifestyle change that helps with your health wealth and self. And helps you release the nicotine addiction. That has  become a curse and taken over your life.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                      height: 1.4,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 3.h),
                  child: Text(
                    "FILL IN OUR QUESTIONNAIRE 4 LIFE.",
                    style: TextStyle(
                        color: kSignupColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 1.h),
                  child: Text(
                    "It’s one step at a time.",
                    style: TextStyle(color: Colors.black, fontSize: 13.sp),
                  ),
                ),
                Container(
                  child: Image.asset("assets/logo2.png"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 1.h),
                  child: Text(
                    "Join our community.",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w300),
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
