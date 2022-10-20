import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget backButton(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(left: 5.sp),
    child: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(100.0),
          ),
        ),
        padding: EdgeInsets.only(left: 5.sp),
        child: Center(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 15,
          ),
        ),
      ),
    ),
  );
}
