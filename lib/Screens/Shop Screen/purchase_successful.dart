import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../../Constant.dart';

class PurchaseSuccessful extends StatefulWidget {
  const PurchaseSuccessful({Key? key}) : super(key: key);

  @override
  _PurchaseSuccessfulState createState() => _PurchaseSuccessfulState();
}

class _PurchaseSuccessfulState extends State<PurchaseSuccessful> {
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
              height: 12.h,
            ),
            Text(
              "Yay!!",
              style: TextStyle(
                  color: kSigninColor,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w700,
                  height: 2,
                  letterSpacing: 2),
            ),
            Text(
              "Your purchase was successful.",
              style: TextStyle(
                  color: kSignupColor,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w300,
                  height: 1.5),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              child: Image.asset("assets/on_the_way.png"),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "Your package is on it’s way.",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w300,
                  height: 1.5),
            ),
            SizedBox(
              height: 12.h,
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
              //         builder: (context) => DashBord(),
              //       ),
              //     );
              //   },
              //   child: Text(
              //     "Go Back",
              //     style: TextStyle(
              //         color: Colors.white,
              //         fontWeight: FontWeight.w600,
              //         fontSize: 16.sp),
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
