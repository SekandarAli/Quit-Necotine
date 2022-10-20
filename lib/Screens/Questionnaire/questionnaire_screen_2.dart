import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nicotine/Screens/Components/snackBar.dart';
import 'package:nicotine/Screens/Questionnaire/services/questions_submission_services.dart';
import 'package:sizer/sizer.dart';

import '../../Constant.dart';
import '../Components/backButton.dart';
import 'questionnaire_screen3.dart';

class QuestionnaireScreen2 extends StatefulWidget {
  const QuestionnaireScreen2({Key? key}) : super(key: key);

  @override
  _QuestionnaireScreen2State createState() => _QuestionnaireScreen2State();
}

class _QuestionnaireScreen2State extends State<QuestionnaireScreen2> {
  TextEditingController stop_smoking = TextEditingController();
  TextEditingController reason = TextEditingController();
  TextEditingController longes_period = TextEditingController();
  TextEditingController think_helped = TextEditingController();
  TextEditingController started_again = TextEditingController();
  TextEditingController cig_per_day = TextEditingController();
  TextEditingController main_reasion = TextEditingController();
  TextEditingController list_any_diagnoses = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool? value = false;
  int val = -1;
  int val2 = -1;
  int val3 = -1;
  bool _isLoading= false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: backButton(context),
        backgroundColor: Colors.white,
        title: Text(
          "Questionnaire",
          style: TextStyle(fontSize: 16.sp, color: Colors.black),
        ),
        actions: [
          // Icon(
          //   Icons.more_horiz,
          //   size: 24.sp,
          // ),
          // SizedBox(
          //   width: 5.sp,
          // ),
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
                height: 2.h,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            height: 6.h,
                            width: 90.w,
                            // color: Colors.purple,
                            child: RichText(
                              text: TextSpan(
                                text:
                                    'What are your main reasons for wanting to stop Smoking? ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' (Required)',
                                      style: TextStyle(
                                          color: kSignupColor,
                                          height: 1.5,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12.sp)),
                                ],
                              ),
                            ),
                            // Text("Name", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12.sp),) ,
                          ),
                          Container(
                            // height: 15.h,
                            width: 90.w,
                            // margin: EdgeInsets.only(top: 5.sp),
                            // color: Colors.pink,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter at least one reason';
                                }
                                return null;
                              },
                              controller: reason,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              maxLines: 5,
                              // validator: ,
                              decoration: InputDecoration(
                                // contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 0.3.sp,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                              ),
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
                            height: 6.h,
                            width: 90.w,
                            // color: Colors.purple,
                            child: RichText(
                              text: TextSpan(
                                text:
                                    'How many times have you tried to stop smoking in the last 5 years? ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' (Required)',
                                      style: TextStyle(
                                          color: kSignupColor,
                                          height: 1.5,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12.sp)),
                                ],
                              ),
                            ),
                            // Text("Name", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12.sp),) ,
                          ),
                          Container(
                            // height: 7.h,
                            width: 90.w,
                            // margin: EdgeInsets.only(top: 5.sp),
                            // color: Colors.pink,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please fill this field';
                                }
                                return null;
                              },
                              controller: stop_smoking,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                              // validator: ,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 0, 0, 0),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 0.3.sp,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            height: 6.h,
                            width: 90.w,
                            // color: Colors.purple,
                            child: RichText(
                              text: TextSpan(
                                text:
                                    'What is the longest period of time you have achieved? ( Enter number of weeks )',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' (Required)',
                                      style: TextStyle(
                                          color: kSignupColor,
                                          height: 1.5,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12.sp)),
                                ],
                              ),
                            ),
                            // Text("Name", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12.sp),) ,
                          ),
                          Container(
                            // height: 7.h,
                            width: 90.w,
                            // margin: EdgeInsets.only(top: 5.sp),
                            // color: Colors.pink,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please fill this field';
                                }
                                return null;
                              },
                              controller: longes_period,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 0, 0, 0),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 0.3.sp,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            height: 6.h,
                            width: 90.w,
                            // color: Colors.purple,
                            child: RichText(
                              text: TextSpan(
                                text:
                                    'If you have managed to stop smoking in the past what do you think helped? ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' (Required)',
                                      style: TextStyle(
                                          color: kSignupColor,
                                          height: 1.5,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12.sp)),
                                ],
                              ),
                            ),
                            // Text("Name", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12.sp),) ,
                          ),
                          Container(
                            // height: 7.h,
                            width: 90.w,
                            // margin: EdgeInsets.only(top: 5.sp),
                            // color: Colors.pink,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please fill this field';
                                }
                                return null;
                              },
                              controller: think_helped,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              // validator: ,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 0, 0, 0),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 0.3.sp,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            height: 6.h,
                            width: 90.w,
                            // color: Colors.purple,
                            child: RichText(
                              text: TextSpan(
                                text:
                                    'What do you feel was the main reason that you started again? ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' (Required)',
                                      style: TextStyle(
                                          color: kSignupColor,
                                          height: 1.5,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12.sp)),
                                ],
                              ),
                            ),
                            // Text("Name", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12.sp),) ,
                          ),
                          Container(
                            // height: 7.h,
                            width: 90.w,
                            // margin: EdgeInsets.only(top: 5.sp),
                            // color: Colors.pink,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter at least one reason';
                                }
                                return null;
                              },
                              controller: started_again,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              // validator: ,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 0, 0, 0),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 0.3.sp,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            height: 6.h,
                            width: 90.w,
                            // color: Colors.purple,
                            child: RichText(
                              text: TextSpan(
                                text:
                                    'How many cigarettes do you smoke per day? ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' (Required)',
                                      style: TextStyle(
                                          color: kSignupColor,
                                          height: 1.5,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12.sp)),
                                ],
                              ),
                            ),
                            // Text("Name", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12.sp),) ,
                          ),
                          Container(
                            // height: 7.h,
                            width: 90.w,
                            // margin: EdgeInsets.only(top: 5.sp),
                            // color: Colors.pink,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter at least one reason';
                                }
                                return null;
                              },
                              controller: cig_per_day,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                              // validator: ,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 0, 0, 0),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 0.3.sp,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            height: 6.h,
                            width: 90.w,
                            // color: Colors.purple,
                            child: RichText(
                              text: TextSpan(
                                text:
                                    'What do you think are the main reasons that you smoke? ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' (Required)',
                                      style: TextStyle(
                                          color: kSignupColor,
                                          height: 1.5,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12.sp)),
                                ],
                              ),
                            ),
                            // Text("Name", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12.sp),) ,
                          ),
                          Container(
                            // height: 7.h,
                            width: 90.w,
                            // margin: EdgeInsets.only(top: 5.sp),
                            // color: Colors.pink,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter at least one reason';
                                }
                                return null;
                              },
                              controller: main_reasion,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              // validator: ,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 0, 0, 0),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 0.3.sp,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      height: 6.h,
                      width: 90.w,
                      // color: Colors.purple,
                      child: RichText(
                        text: TextSpan(
                          text:
                              'How soon after waking do you have your first cigarette? ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 12.sp),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' (Required)',
                                style: TextStyle(
                                    color: kSignupColor,
                                    height: 1.5,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp)),
                          ],
                        ),
                      ),
                      // Text("Name", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12.sp),) ,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.sp, right: 10.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // width: 50.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 4.h,
                                  // color: Colors.yellowAccent,
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          // color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(100.0),
                                          ),
                                        ),
                                        width: 5.w,
                                        height: 5.w,
                                        child: Radio(
                                          // overlayColor: ,
                                          value: 1,
                                          groupValue: val,
                                          onChanged: (value) {
                                            setState(() {
                                              val = int.parse(value.toString());
                                            });
                                          },
                                          activeColor: kSignupColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text("Less than 5 minutes",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 4.h,
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          // color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(100.0),
                                          ),
                                        ),
                                        width: 5.w,
                                        height: 5.w,
                                        child: Radio(
                                          // overlayColor: ,
                                          value: 2,
                                          groupValue: val,
                                          onChanged: (value) {
                                            setState(() {
                                              val = int.parse(value.toString());
                                            });
                                          },
                                          activeColor: kSignupColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text("Between 15-30 minutes",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10.sp)),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 4.h,
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          // color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(100.0),
                                          ),
                                        ),
                                        width: 5.w,
                                        height: 5.w,
                                        child: Radio(
                                          // overlayColor: ,
                                          value: 3,
                                          groupValue: val,
                                          onChanged: (value) {
                                            setState(() {
                                              val = int.parse(value.toString());
                                            });
                                          },
                                          activeColor: kSignupColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text("Between 1-2 hours",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10.sp)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 4.h,
                                // color: Colors.yellowAccent,
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        // color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100.0),
                                        ),
                                      ),
                                      width: 5.w,
                                      height: 5.w,
                                      child: Radio(
                                        // overlayColor: ,
                                        value: 4,
                                        groupValue: val,
                                        onChanged: (value) {
                                          setState(() {
                                            val = int.parse(value.toString());
                                          });
                                        },
                                        activeColor: kSignupColor,
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    Text("Between 5-15 minutes",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ),
                              Container(
                                height: 4.h,
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        // color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100.0),
                                        ),
                                      ),
                                      width: 5.w,
                                      height: 5.w,
                                      child: Radio(
                                        // overlayColor: ,
                                        value: 5,
                                        groupValue: val,
                                        onChanged: (value) {
                                          setState(() {
                                            val = int.parse(value.toString());
                                          });
                                        },
                                        activeColor: kSignupColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text("Between 30-60 minutes",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10.sp)),
                                  ],
                                ),
                              ),
                              Container(
                                height: 4.h,
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        // color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100.0),
                                        ),
                                      ),
                                      width: 5.w,
                                      height: 5.w,
                                      child: Radio(
                                        // overlayColor: ,
                                        value: 6,
                                        groupValue: val,
                                        onChanged: (value) {
                                          setState(() {
                                            val = int.parse(value.toString());
                                          });
                                        },
                                        activeColor: kSignupColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text("Over 2 hours",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10.sp)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      height: 6.h,
                      width: 90.w,
                      // color: Colors.purple,
                      child: RichText(
                        text: TextSpan(
                          text:
                              'Have you been diagnosed with any smoking related illness? ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 12.sp),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' (Required)',
                                style: TextStyle(
                                    color: kSignupColor,
                                    height: 1.5,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp)),
                          ],
                        ),
                      ),
                      // Text("Name", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12.sp),) ,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.sp, right: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 4.h,
                            // color: Colors.yellowAccent,
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    // color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100.0),
                                    ),
                                  ),
                                  width: 5.w,
                                  height: 5.w,
                                  child: Radio(
                                    // overlayColor: ,
                                    value: 1,
                                    groupValue: val2,
                                    onChanged: (value) {
                                      setState(() {
                                        val2 = int.parse(value.toString());
                                      });
                                    },
                                    activeColor: kSignupColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text("Yes",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                          Container(
                            height: 4.h,
                            // color: Colors.yellowAccent,
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    // color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100.0),
                                    ),
                                  ),
                                  width: 5.w,
                                  height: 5.w,
                                  child: Radio(
                                    // overlayColor: ,
                                    value: 2,
                                    groupValue: val2,
                                    onChanged: (value) {
                                      setState(() {
                                        val2 = int.parse(value.toString());
                                      });
                                    },
                                    activeColor: kSignupColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text("No",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                              height: 6.h,
                              width: 90.w,
                              // color: Colors.purple,
                              child: Text(
                                "If you answered Yes to the previous question, please list any diagnoses.",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp),
                              )
                              // Text("Name", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12.sp),) ,
                              ),
                          Container(
                            // height: 15.h,
                            width: 90.w,
                            // margin: EdgeInsets.only(top: 5.sp),
                            // color: Colors.pink,
                            child: TextFormField(
                              maxLines: 5,
                              controller: list_any_diagnoses,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              // validator: ,
                              decoration: InputDecoration(
                                // contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 0.3.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      height: 4.h,
                      width: 90.w,
                      // color: Colors.purple,
                      child: RichText(
                        text: TextSpan(
                          text: 'Are you on any medication? ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 12.sp),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' (Required)',
                                style: TextStyle(
                                    color: kSignupColor,
                                    height: 1.5,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp)),
                          ],
                        ),
                      ),
                      // Text("Name", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12.sp),) ,
                    ),
                    Container(
                      width: 95.w,
                      margin: EdgeInsets.only(left: 10.sp, right: 20.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 4.h,
                            // color: Colors.yellowAccent,
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    // color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100.0),
                                    ),
                                  ),
                                  width: 5.w,
                                  height: 5.w,
                                  child: Radio(
                                    // overlayColor: ,
                                    value: 1,
                                    groupValue: val3,
                                    onChanged: (value) {
                                      setState(() {
                                        val3 = int.parse(value.toString());
                                      });
                                    },
                                    activeColor: kSignupColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text("Yes",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   width: 30.w,
                          // ),
                          Container(
                            height: 4.h,
                            // color: Colors.yellowAccent,
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    // color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100.0),
                                    ),
                                  ),
                                  width: 5.w,
                                  height: 5.w,
                                  child: Radio(
                                    // overlayColor: ,
                                    value: 2,
                                    groupValue: val3,
                                    onChanged: (value) {
                                      setState(() {
                                        val3 = int.parse(value.toString());
                                      });
                                    },
                                    activeColor: kSignupColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text("No",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
             _isLoading?CircularProgressIndicator(color: kSignupColor,): Container(
                height: 8.h,
                width: 30.w,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: ElevatedButton(
                  style: ButtonStyle(   backgroundColor: MaterialStateProperty.all(kSignupColor),shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ) ),

                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        val != -1 &&
                        val2 != -1 &&
                        val3 != -1) {

setState(() {
  _isLoading=true;
});
                      QuestionsAnswr().questionTwoUpload(anyDiagnoses: list_any_diagnoses.text, longestPeroid: longes_period.text, mainReason: reason.text, managedStopSmoking: stop_smoking.text, numberOfCigratte:cig_per_day.text, startedAgain: started_again.text, triedStopSmoking: stop_smoking.text, value1: val.toString(), value2: val2.toString(), value3: val3.toString(), whyYouSmoke: main_reasion.text).then((value) {

                        setState(() {
                          _isLoading = false;
                        });

                        if(value=="success") {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuestionnaireScreen3(),
                            ),
                          );
                        }
                      });

                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          showSnackbar("Please fill all the required fields"));
                    }
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp),
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
