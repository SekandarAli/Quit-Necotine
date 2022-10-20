import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nicotine/Constant.dart';
import 'package:nicotine/Screens/Components/backButton.dart';
import 'package:nicotine/Screens/Home%20Screens/dash_bord.dart';
import 'package:nicotine/Screens/auth_screens/login_screen.dart';
import 'package:nicotine/Screens/start_up.dart';
import 'package:sizer/sizer.dart';

import 'Components/bullet_list.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: backButton(context),
        backgroundColor: Colors.white,
        title: Text(
          "Subscription",
          style: TextStyle(fontSize: 16.sp, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) =>  DashBord()));
              },
              child: Text(
                "Skip",
                style: TextStyle(fontSize: 12.sp, color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            width: 8.sp,
          ),
        ],
      ),
      body: Container(
        height: 100.h,
        width: 100.w,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 3.h,
              ),
              Container(
                child: Image.asset("assets/gift_box.png"),
              ),
              SizedBox(
                height: 3.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 7.w),
                child: Text(
                  "This 120-day programme is designed to assist you with quitting nicotine for good, whilst reducing feelings of anxiety, depression and cravings usually associated with this process. But it also helps you to build yourself back up with strong foundations, to be able to resist going back into a mind state of addiction. As smoking is a habit. And not an addiction.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.black,
                      height: 1.2,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 7.w),
                  // height: 34.h,
                  decoration: BoxDecoration(
                    // color: Colors.cyanAccent,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(width: 1.4.sp, color: kSigninColor),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "Upon subscribing you will get:",
                        style: TextStyle(
                            color: kSigninColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp),
                      ),
                      BulletList([
                        '4-month supply of Imperial Herbal Smoking Mix (12 pouches) to add to your own tobacco, as directed, plus 12 booklets of rolling papers.',
                        '1-month supply of First Aid + Tissue Salts for Immediate Relief (500 pills) to take daily to ease the cravings.',
                        '3-month supply of Ultimate Health Tissue Salts (500 pills).',
                        'Instructions on how to complete the Hair Test 4 Life and a prepaid envelope for its return.',
                        'Full details of how the programme works and of how to get involved.',
                      ]),
                    ],
                  )),
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 7.h,
                width: 65.w,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                // child: RaisedButton(
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(15)),
                //   color: kSignupColor,
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => PaymentsScreen(),
                //       ),
                //     );
                //   },
                //   child: Text(
                //     "Subscribe Now",
                //     style: TextStyle(
                //         color: Colors.white,
                //         fontWeight: FontWeight.w600,
                //         fontSize: 16.sp),
                //   ),
                // ),
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
