import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Constant.dart';

class WellDoneScreen extends StatelessWidget {
  const WellDoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 17.h,
            ),
            Container(
              child: Image.asset("assets/well_done.png"),
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              "Well Done!",
              style: TextStyle(
                  color: kSigninColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 28.sp),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              "You have made it.",
              style: TextStyle(
                  color: kSignupColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp),
            ),
            SizedBox(
              height: 7.h,
            ),
            Text(
              "A warm welcome to our\n Quit Nicotine 4 Life in 120\ndays Programme.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  height: 1.7,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 7.h,
            ),
            Container(
              height: 7.h,
              width: 65.w,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
            ),
          ],
        ),
      ),
    );
  }
}
