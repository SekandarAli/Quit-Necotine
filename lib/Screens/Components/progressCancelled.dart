import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nicotine/Screens/Components/dialog_box.dart';
import 'package:nicotine/blocs/User/user_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sizer/sizer.dart';

import '../../Constant.dart';
import '../../blocs/Goal/goal_bloc.dart';
import '../../models/UserGoal.dart';
import '../../utils/goalHelper.dart';

Widget progressCancelled(UserGoal userGoal, BuildContext context) {
  return Container(
      margin: EdgeInsets.only(top: 2.h),
      height: 18.h,
      width: 95.w,
      decoration: BoxDecoration(
        // color: Colors.yellow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1.sp, color: kSignupColor),
        color: Colors.white,
        // kLightColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 6.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    userGoal.goalName!,
                    // "Quit Nicotine",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 18.sp),
                  ),
                ],
              )),
          SizedBox(
            height: 1.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 6.w),
            child: Text(
              "Progress",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 11.sp),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: LinearPercentIndicator(
                  width: 85.w,
                  // width: MediaQuery.of(context).size.width - 50,
                  animation: true,
                  lineHeight: 1.6.h,
                  animationDuration: 2000,
                  percent: goalPercentage(userGoal, DateTime.now()) / 100,
                  center: Text(
                    "${goalPercentage(userGoal, DateTime.now())} %",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w500,
                        height: 1),
                  ),
                  // linearStrokeCap: LinearStrokeCap.roundAll,
                  barRadius: Radius.circular(20),
                  // curve: Curves.linear,
                  progressColor: kSignupColor,
                ),
              ),
              // Icon(
              //   Icons.arrow_forward_ios_rounded,
              //   color: Colors.white,
              // ),
              SizedBox(
                width: 1.sp,
              )
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 6.w),
            // width: 60.w,
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  color: kSigninColor,
                ),
                Text(
                  "  ${userGoal.goalDays.toString()} Days",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp),
                ),
                Spacer(),
                // Icon(
                //   Icons.access_time,
                //   color: kSignupColor,
                // ),
                // Text(
                //   "  ${userGoal.goalTimeSlot.toString()} min time Slots",
                //   style: TextStyle(
                //       color: Colors.black,
                //       fontWeight: FontWeight.w400,
                //       fontSize: 11.sp),
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
        ],
      ));
}
