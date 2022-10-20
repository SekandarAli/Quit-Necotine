import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Timer extends StatelessWidget {
  final int time;
  final String title;

  const Timer({Key? key, required this.time, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.w,
      height: 8.h,
      // color: Colors.cyanAccent,
      child: Column(
        children: [
          Text(time.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 25.sp),),
          Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 10.sp)),
        ],
      ),
    );
  }
}
