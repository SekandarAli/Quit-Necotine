import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nicotine/Screens/Components/backButton.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final IconData icon;

  const CustomAppBar({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 3.h),
      height: 8.h,
      // color: Colors.yellow,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            backButton(context),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
            ),

            Text(
              title,
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
            ),
            SizedBox(
              width: 15.w,
            ),
            // Icon(icon, size: 26.sp, color: Colors.white,)
          ],
        ),
      ),
    );
  }
}
