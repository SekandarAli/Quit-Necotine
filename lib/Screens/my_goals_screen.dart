import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:nicotine/Constant.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'Home Screens/calender_screen.dart';
import 'today_activity.dart';

class MyGoalsScreen extends StatefulWidget {
  const MyGoalsScreen({Key? key}) : super(key: key);

  @override
  _MyGoalsScreenState createState() => _MyGoalsScreenState();
}

class _MyGoalsScreenState extends State<MyGoalsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 5.sp),
          child: Container(
            margin: EdgeInsets.only(
                top: 1.4.h, bottom: 1.4.h, left: 2.w, right: 2.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Builder(
              builder: (context) => IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 12.sp,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.black,
        title: Text(
          "My Goals",
          style: TextStyle(fontSize: 16.sp),
        ),
        actions: [
          Icon(
            Icons.more_horiz,
            size: 24.sp,
          ),
          SizedBox(
            width: 5.sp,
          ),
        ],
      ),
      body: Container(
        height: 100.h,
        width: 100.w,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 2.h,
            ),
            ListTile(
              title: Text(
                "Quit the Nicotine",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 17.sp),
              ),
              subtitle: Container(
                margin: EdgeInsets.only(top: 1.h, right: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "120 Day",
                      style: TextStyle(
                          color: Color(0xffF8DB08),
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp),
                    ),
                    Text(
                      "10 min",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp),
                    ),
                    Text(
                      "150 Points",
                      style: TextStyle(
                          color: kSignupColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
              trailing: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CalenderScreen(
                                show_appbar: true,
                              )));
                },
                child: Container(
                  // margin: EdgeInsets.only(right: 3.w),
                  height: 5.h,
                  width: 11.w,
                  decoration: BoxDecoration(
                      color: const Color(0xffF8DB08),
                      borderRadius: BorderRadius.circular(100)),
                  child: Image.asset(
                    "assets/Calendar2.png",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            TimelineTile(
              indicatorStyle: IndicatorStyle(
                color: kSigninColor,
                iconStyle: IconStyle(
                    color: Colors.black,
                    iconData: Icons.circle,
                    fontSize: 11.sp),
              ),
              afterLineStyle: const LineStyle(color: kSigninColor),
              beforeLineStyle: const LineStyle(color: kSigninColor),
              alignment: TimelineAlign.manual,
              lineXY: 0.25,
              hasIndicator: true,
              endChild: Padding(
                padding: EdgeInsets.all(6.sp),
                child: GestureDetector(
                  onTap: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                          // alignment: Alignment.bottomCenter,
                          backgroundColor: kLightColor,
                          titlePadding: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          title: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              height: 18.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                  color: kLightColor,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: kSignupColor, width: 1.sp)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 8.h,
                                    width: 16.w,
                                    child: Image.asset(
                                      "assets/activitey.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Text(
                                    "Your Earn 10 Points",
                                    style: TextStyle(
                                        color: kSigninColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        height: 2),
                                  ),
                                  Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w400,
                                        height: 2),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    );
                    // _animationController.reset();
                    // _animationController.forward();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: kLightColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1.sp, color: kSigninColor)),
                    constraints: BoxConstraints(
                      minHeight: 10.h,
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
                                  "Quit Nicotine",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.sp),
                                ),
                                Icon(
                                  Icons.more_vert_rounded,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          Text(
                            "Complete  10 Points",
                            style: TextStyle(
                                color: kSigninColor,
                                fontWeight: FontWeight.w300,
                                fontSize: 10.sp,
                                height: 1.3),
                          ),
                          // SizedBox(height: 5.sp,),
                          Container(
                            margin: EdgeInsets.only(
                              top: 10.sp,
                            ),
                            // width: 60.w,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: kSignupColor,
                                  size: 14.sp,
                                ),
                                Text(
                                  "  25 June, 2021",
                                  style: TextStyle(
                                      color: Colors.white,
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
              ),
              startChild: Container(
                // color: Colors.amberAccent,
                child: Center(
                    child: Text(
                  "Day 1",
                  style: TextStyle(
                      color: kSigninColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 11.sp,
                      height: 2),
                )),
              ),
            ),
            TimelineTile(
              indicatorStyle: IndicatorStyle(
                color: kSigninColor,
                iconStyle: IconStyle(
                    color: Colors.black,
                    iconData: Icons.circle,
                    fontSize: 11.sp),
              ),
              afterLineStyle: LineStyle(color: kSigninColor),
              beforeLineStyle: LineStyle(color: kSigninColor),
              alignment: TimelineAlign.manual,
              lineXY: 0.25,
              hasIndicator: true,
              endChild: Padding(
                padding: EdgeInsets.all(6.sp),
                child: GestureDetector(
                  onTap: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                          // alignment: Alignment.bottomCenter,
                          backgroundColor: kLightColor,
                          titlePadding: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          title: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              height: 18.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                  color: kLightColor,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: kSignupColor, width: 1.sp)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 8.h,
                                    width: 16.w,
                                    child: Image.asset(
                                      "assets/activitey.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Text(
                                    "Your Earn 10 Points",
                                    style: TextStyle(
                                        color: kSigninColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        height: 2),
                                  ),
                                  Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w400,
                                        height: 2),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    );
                    // _animationController.reset();
                    // _animationController.forward();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: kLightColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1.sp, color: kSigninColor)),
                    constraints: BoxConstraints(
                      minHeight: 10.h,
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
                                  "Quit Nicotine",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.sp),
                                ),
                                Icon(
                                  Icons.more_vert_rounded,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          Text(
                            "Complete  10 Points",
                            style: TextStyle(
                                color: kSigninColor,
                                fontWeight: FontWeight.w300,
                                fontSize: 10.sp,
                                height: 1.3),
                          ),
                          // SizedBox(height: 5.sp,),
                          Container(
                            margin: EdgeInsets.only(
                              top: 10.sp,
                            ),
                            // width: 60.w,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: kSignupColor,
                                  size: 14.sp,
                                ),
                                Text(
                                  "  25 June, 2021",
                                  style: TextStyle(
                                      color: Colors.white,
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
              ),
              startChild: Container(
                // color: Colors.amberAccent,
                child: Center(
                    child: Text(
                  "Day 1",
                  style: TextStyle(
                      color: kSigninColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 11.sp,
                      height: 2),
                )),
              ),
            ),
            TimelineTile(
              indicatorStyle: IndicatorStyle(
                color: kSigninColor,
                iconStyle: IconStyle(
                    color: Colors.black,
                    iconData: Icons.circle,
                    fontSize: 11.sp),
              ),
              afterLineStyle: LineStyle(color: kSigninColor),
              beforeLineStyle: LineStyle(color: kSigninColor),
              alignment: TimelineAlign.manual,
              lineXY: 0.25,
              hasIndicator: true,
              endChild: Padding(
                padding: EdgeInsets.all(6.sp),
                child: GestureDetector(
                  onTap: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                          // alignment: Alignment.bottomCenter,
                          backgroundColor: kLightColor,
                          titlePadding: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          title: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              height: 18.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                  color: kLightColor,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: kSignupColor, width: 1.sp)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 8.h,
                                    width: 16.w,
                                    child: Image.asset(
                                      "assets/activitey.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Text(
                                    "Your Earn 10 Points",
                                    style: TextStyle(
                                        color: kSigninColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        height: 2),
                                  ),
                                  Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w400,
                                        height: 2),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    );
                    // _animationController.reset();
                    // _animationController.forward();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: kLightColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1.sp, color: kSigninColor)),
                    constraints: BoxConstraints(
                      minHeight: 10.h,
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
                                  "Quit Nicotine",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.sp),
                                ),
                                Icon(
                                  Icons.more_vert_rounded,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          Text(
                            "Complete  10 Points",
                            style: TextStyle(
                                color: kSigninColor,
                                fontWeight: FontWeight.w300,
                                fontSize: 10.sp,
                                height: 1.3),
                          ),
                          // SizedBox(height: 5.sp,),
                          Container(
                            margin: EdgeInsets.only(
                              top: 10.sp,
                            ),
                            // width: 60.w,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: kSignupColor,
                                  size: 14.sp,
                                ),
                                Text(
                                  "  25 June, 2021",
                                  style: TextStyle(
                                      color: Colors.white,
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
              ),
              startChild: Container(
                // color: Colors.amberAccent,
                child: Center(
                    child: Text(
                  "Day 1",
                  style: TextStyle(
                      color: kSigninColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 11.sp,
                      height: 2),
                )),
              ),
            ),
            TimelineTile(
              indicatorStyle: IndicatorStyle(
                color: kSigninColor,
                iconStyle: IconStyle(
                    color: Colors.black,
                    iconData: Icons.circle,
                    fontSize: 11.sp),
              ),
              afterLineStyle: LineStyle(color: kSigninColor),
              beforeLineStyle: LineStyle(color: kSigninColor),
              alignment: TimelineAlign.manual,
              lineXY: 0.25,
              hasIndicator: true,
              endChild: Padding(
                padding: EdgeInsets.all(6.sp),
                child: GestureDetector(
                  onTap: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                          // alignment: Alignment.bottomCenter,
                          backgroundColor: kLightColor,
                          titlePadding: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          title: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              height: 18.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                  color: kLightColor,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: kSignupColor, width: 1.sp)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 8.h,
                                    width: 16.w,
                                    child: Image.asset(
                                      "assets/activitey.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Text(
                                    "Your Earn 10 Points",
                                    style: TextStyle(
                                        color: kSigninColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        height: 2),
                                  ),
                                  Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w400,
                                        height: 2),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    );
                    // _animationController.reset();
                    // _animationController.forward();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: kLightColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1.sp, color: kSigninColor)),
                    constraints: BoxConstraints(
                      minHeight: 10.h,
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
                                  "Quit Nicotine",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.sp),
                                ),
                                Icon(
                                  Icons.more_vert_rounded,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          Text(
                            "In Progress",
                            style: TextStyle(
                                color: kSigninColor,
                                fontWeight: FontWeight.w300,
                                fontSize: 10.sp,
                                height: 1.3),
                          ),
                          // SizedBox(height: 5.sp,),
                          Container(
                            margin: EdgeInsets.only(
                              top: 10.sp,
                            ),
                            // width: 60.w,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: kSignupColor,
                                  size: 14.sp,
                                ),
                                Text(
                                  "  25 June, 2021",
                                  style: TextStyle(
                                      color: Colors.white,
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
              ),
              startChild: Container(
                // color: Colors.amberAccent,
                child: Center(
                    child: Text(
                  "Day 1",
                  style: TextStyle(
                      color: kSigninColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 11.sp,
                      height: 2),
                )),
              ),
            ),
            Spacer(),
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
              //         builder: (context) => TodayActivity(),
              //       ),
              //     );
              //   },
              //   child: Text(
              //     "Upload Today's Activity",
              //     style: TextStyle(
              //         color: Colors.white,
              //         fontWeight: FontWeight.w600,
              //         fontSize: 15.sp),
              //   ),
              // ),
            ),
            SizedBox(
              height: 4.h,
            ),
          ],
        ),
      ),
    );
  }
}
