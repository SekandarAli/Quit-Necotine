import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nicotine/Constant.dart';
import 'package:nicotine/Screens/Components/backButton.dart';
import 'package:nicotine/Screens/timeline_screen.dart';
import 'package:nicotine/Screens/today_activity.dart';
import 'package:nicotine/models/MyActivity.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../utils/date_util.dart';
import '../utils/goalHelper.dart';
import '30_days_progress.dart';

class MyActivity extends StatefulWidget {
  const MyActivity({Key? key}) : super(key: key);

  @override
  _MyActivityState createState() => _MyActivityState();
}

class _MyActivityState extends State<MyActivity> {
  final String iddddd = FirebaseAuth.instance.currentUser!.uid;
  var userIDD;
  var _activityCreationDate;
  var _todayDate = "${formatterMonDateYear.format(DateTime.now())}";

  @override
  void initState() {
    super.initState();
    getID();
  }

  getID() {
    FirebaseFirestore.instance
        .collection("activity")
        .doc(iddddd)
        .collection("activitiessss")
        .snapshots()
        .forEach((element) {
      element.docs.forEach((element) {
        userIDD = element.get("user.userId");
        _activityCreationDate = element.get("activityName");
        print(userIDD);
      });
    });
  }

  final String id = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    Widget oneTimelineTile(UserActivity thisActivity, int currentIndex,
        DateTime activityFirstDate) {
      return TimelineTile(
        indicatorStyle: IndicatorStyle(
          color: kSigninColor,
          iconStyle: IconStyle(
              color: Colors.white, iconData: Icons.circle, fontSize: 11.sp),
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
                  backgroundColor: Colors.white,
                  //  kLightColor,
                  titlePadding: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              );
            },
          ),
        ),
        startChild: Container(
          // color: Colors.amberAccent,
          child: Center(
              child: Text(
            "Day ${numberDay(thisActivity.activityCreationDate!, activityFirstDate)}",
            style: TextStyle(
                color: kSigninColor,
                fontWeight: FontWeight.w600,
                fontSize: 11.sp,
                height: 2),
          )),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: backButton(context),

        // ),
        backgroundColor: Colors.white,
        title: Text(
          "My Activity",
          style: TextStyle(fontSize: 16.sp, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {},
              // onTap: () => Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => DaysProgress(
              //         userId: userIDD,
              //       ),
              //     )),
              child: Container(
                // margin: EdgeInsets.only(right: 3.w),
                height: 5.h,
                width: 11.w,
                decoration: BoxDecoration(
                    color: Color(0xffF8DB08),
                    borderRadius: BorderRadius.circular(100)),
                child: Icon(
                  Icons.history,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5.sp,
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 7.h,
        width: 65.w,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kSignupColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
          ),
          onPressed: () async {
            if (_activityCreationDate == _todayDate) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                    // alignment: Alignment.bottomCenter,
                    backgroundColor: Colors.white,
                    titlePadding: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    title: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 18.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: kSignupColor, width: 1.sp)),
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
                              "Today's activity  is uploaded already",
                              style: TextStyle(
                                  color: kSigninColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  height: 2),
                            ),
                            Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400,
                                  height: 2),
                            ),
                          ],
                        ),
                      ),
                    )),
              );
            } else if (_activityCreationDate != _todayDate) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TodayActivity()));
            }
          },
          child: Text(
            "Upload Today's Activity",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15.sp),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        height: 100.h,
        width: 100.w,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Container(
              height: 86.h,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("activity")
                    .doc(iddddd)
                    .collection("activitiessss")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) => TimeLine(
                      index: index,
                      snap: snapshot.data?.docs[index].data(),
                    ),
                  );
                },
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
