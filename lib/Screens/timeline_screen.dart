import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../Constant.dart';

class TimeLine extends StatelessWidget {
  final snap;
  int index  ;


  TimeLine({required this.snap, required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int count = 1;
    return   TimelineTile(
      indicatorStyle: IndicatorStyle(
        color: kSigninColor,
        iconStyle: IconStyle(
            color: Colors.black,
            iconData: Icons.circle,
            fontSize: 11.sp),
      ),
      afterLineStyle: LineStyle(color: kSigninColor),
      beforeLineStyle: const LineStyle(color: kSigninColor),
      alignment: TimelineAlign.manual,
      lineXY: 0.25,
      hasIndicator: true,
      endChild: Padding(
        padding: EdgeInsets.all(6.sp),
        child: Container(
          decoration: BoxDecoration(
              color: kLightColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 1.sp, color: kSignupColor)),
          constraints: BoxConstraints(
            minHeight: 20.h,
          ),
          child: Padding(
            padding: EdgeInsets.all(10.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${snap["activityName"]}",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp),
                      ),
                      const Icon(
                        Icons.more_vert_rounded,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                Text(
                  "In Process",
                  style: TextStyle(
                      color: kSigninColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 10.sp,
                      height: 1.3),
                ),
                // SizedBox(height: 5.sp,),
                Text(
                  "Tasks",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                      height: 2),
                ),
                Text(
                  "Drink ${snap["glassesOfWater"]} glass water",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 10.sp,
                      height: 1.3),
                ),
                Text(
                  "Use mineral food. ${snap["foodAte"]}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 10.sp,
                      height: 1.3),
                ),
                Text(
                  "Walk ${snap["stepsWalked"]} step today",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 10.sp,
                      height: 1.3),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10.sp,
                  ),
                  // width: 60.w,
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: kSigninColor,
                        size: 14.sp,
                      ),
                      Text(
                        " ${snap["activityName"]}",
                        style: TextStyle(
                            color: kSigninColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 10.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      startChild: Container(
        // color: Colors.amberAccent,
        child: Center(
            child: Text("Day ${count + index} ",
              style: TextStyle(
                  color: kSigninColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 11.sp,
                  height: 2),
            )),
      ),
    );
  }
}

