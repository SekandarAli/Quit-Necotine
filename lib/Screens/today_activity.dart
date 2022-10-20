import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nicotine/Screens/Components/backButton.dart';
import 'package:nicotine/Screens/Components/snackBar.dart';
import 'package:nicotine/blocs/Activity/activity_bloc.dart';
import 'package:nicotine/blocs/User/user_bloc.dart';
import 'package:nicotine/utils/date_util.dart';
import 'package:sizer/sizer.dart';

import '../Constant.dart';

class TodayActivity extends StatefulWidget {
  const TodayActivity({Key? key}) : super(key: key);

  @override
  _TodayActivityState createState() => _TodayActivityState();
}

class _TodayActivityState extends State<TodayActivity> {
  TextEditingController drink = TextEditingController();
  TextEditingController eat = TextEditingController();
  TextEditingController walk = TextEditingController();
  TextEditingController cigrettes = TextEditingController();
  TextEditingController herbalMix = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(

        create: (context) => UserBloc()..add(CheckIfLoggedIn()),

      child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: backButton(context),

        backgroundColor: Colors.white,
        title: Text(
          "Today's Activity",
          style: TextStyle(fontSize: 16.sp, color: Colors.black),
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
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 3.h,
              ),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            // height: 3.h,
                            width: 90.w,
                            // color: Colors.purple,
                            child: Text(
                              "How many glasses of water did you drink today?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15),
                            ),
                          ),
                          Container(
                            // height: 7.h,
                            width: 90.w,
                            // margin: EdgeInsets.symmetric(horizontal: 5.w),
                            // color: Colors.pink,
                            child: TextFormField(
                              controller: drink,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2),
                              ],
                              cursorColor: Colors.black,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              // maxLines: 5,
                              // validator: ,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Water",
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w300),
                                  // contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 0.6.sp,
                                        color: kSignupColor,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: kSignupColor,
                                      width: 0.5.sp,
                                    ),
                                  ),
                                  prefixIcon: Image.asset(
                                    "assets/water.png",
                                    color: kSignupColor,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            // height: 3.h,
                            width: 90.w,
                            // color: Colors.purple,
                            child: Text(
                              "What food have you eaten today?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15),
                            ),
                          ),
                          Container(
                            // height: 7.h,
                            width: 90.w,
                            // margin: EdgeInsets.symmetric(horizontal: 5.w),
                            // color: Colors.pink,
                            child: TextFormField(
                              controller: eat,
                              cursorColor: Colors.black,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              // maxLines: 5,
                              // validator: ,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Noodles",
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w300),
                                  // contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 0.6.sp,
                                        color: kSignupColor,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: kSignupColor,
                                      width: 0.5.sp,
                                    ),
                                  ),
                                  prefixIcon: Image.asset(
                                    "assets/nodels.png",
                                    color: kSignupColor,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            // height: 3.h,
                            width: 90.w,
                            // color: Colors.purple,
                            child: Text(
                              "How many steps have you walked today?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15),
                            ),
                          ),
                          Container(
                            // height: 7.h,
                            width: 90.w,
                            // margin: EdgeInsets.symmetric(horizontal: 5.w),
                            // color: Colors.pink,
                            child: TextFormField(
                              controller: walk,
                              cursorColor: Colors.black,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              // maxLines: 5,
                              // validator: ,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "6,000",
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w300),
                                  // contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 0.6.sp,
                                        color: kSignupColor,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: kSignupColor,
                                      width: 0.5.sp,
                                    ),
                                  ),
                                  prefixIcon: Container(
                                    height: 7.h,
                                    child: Image.asset(
                                      "assets/person.png",
                                      color: kSignupColor,
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            // height: 3.h,
                            width: 90.w,
                            // color: Colors.purple,
                            child: Text(
                              "How many cigarettes have I smoked today?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15),
                            ),
                          ),
                          Container(
                            // height: 7.h,
                            width: 90.w,
                            // margin: EdgeInsets.symmetric(horizontal: 5.w),
                            // color: Colors.pink,
                            child: TextFormField(
                              controller: cigrettes,
                              cursorColor: Colors.black,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              // maxLines: 5,
                              // validator: ,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "5",
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w300),
                                  // contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 0.6.sp,
                                        color: kSignupColor,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: kSignupColor,
                                      width: 0.5.sp,
                                    ),
                                  ),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Container(
                                      height: 2.h,
                                      child: Image.asset(
                                        "assets/cigretteRed.png",
                                        color: kSignupColor,
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            // height: 3.h,
                            width: 90.w,
                            // color: Colors.purple,
                            child: Text(
                              "How much Herbal Smoking Mix have I added to my tobacco? (in grams)",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15),
                            ),
                          ),
                          Container(
                            // height: 7.h,
                            width: 90.w,
                            // margin: EdgeInsets.symmetric(horizontal: 5.w),
                            // color: Colors.pink,
                            child: TextFormField(
                              controller: herbalMix,
                              cursorColor: Colors.black,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              // maxLines: 5,
                              // validator: ,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "100",
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w300),
                                  // contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 0.6.sp,
                                        color: kSignupColor,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: kSignupColor,
                                      width: 0.5.sp,
                                    ),
                                  ),
                                  prefixIcon: Container(
                                    height: 7.h,
                                    child: Image.asset(
                                      "assets/herbalRed.png",
                                      color: kSignupColor,
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              BlocListener<ActivityBloc, ActivityState>(
                listener: (context, state) {
                  if (state is ActivityAdded) {
                    BlocProvider.of<ActivityBloc>(context)
                        .add(GetUserActivities());
                  }
                },
                child: Container(
                  height: 7.h,
                  width: 65.w,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: ElevatedButton(
                    style: ButtonStyle(   backgroundColor: MaterialStateProperty.all(kSignupColor),shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ) ),

                    ),
                    onPressed: () {
                      if (drink.text.isEmpty ||
                          eat.text.isEmpty ||
                          walk.text.isEmpty ||
                          cigrettes.text.isEmpty ||
                          herbalMix.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            showSnackbar("Please don't leave any field empty"));
                      } else {


                        final userState =
                            BlocProvider.of<UserBloc>(context).state;
                        if (userState is UserLoggedIn) {
                          BlocProvider.of<ActivityBloc>(context).add(AddActivity(
                              user: userState.user,
                              activityName:
                                  "${formatterMonDateYear.format(DateTime.now())}",
                              foodAte: eat.text,
                              glassesOfWater: int.parse(drink.text),
                              stepsWalked: int.parse(walk.text),
                              cigarettesSmoked: int.parse(cigrettes.text),
                              herbalMix: int.parse(herbalMix.text),
                              activityPoints: 10));
                        }

                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                              // alignment: Alignment.bottomCenter,
                              backgroundColor: Colors.white,
                              titlePadding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
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
                                      border: Border.all(
                                          color: kSignupColor, width: 1.sp)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                      }
                      // _animationController.reset();
                      // _animationController.forward();
                    },
                    child: Text(
                      "Upload",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
