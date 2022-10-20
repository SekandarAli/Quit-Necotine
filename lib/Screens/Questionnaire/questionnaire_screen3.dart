import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nicotine/Screens/Components/backButton.dart';
import 'package:nicotine/Screens/Questionnaire/services/questions_submission_services.dart';
import 'package:sizer/sizer.dart';

import '../../Constant.dart';
import '../../blocs/User/user_bloc.dart';
import '../../utils/local_storage.dart';
import '../Components/snackBar.dart';
import '../subscription_Screen.dart';
import 'questionnaire_screen_2.dart';

class QuestionnaireScreen3 extends StatefulWidget {
  const QuestionnaireScreen3({Key? key}) : super(key: key);

  @override
  _QuestionnaireScreen3State createState() => _QuestionnaireScreen3State();
}

class _QuestionnaireScreen3State extends State<QuestionnaireScreen3> {
  TextEditingController anyMedication = TextEditingController();
  TextEditingController provideDetails = TextEditingController();
  TextEditingController moreThanOneHealthIssue = TextEditingController();
  TextEditingController muscluarSkeleton = TextEditingController();
  TextEditingController dermotologistProblem = TextEditingController();
  TextEditingController internalProblem = TextEditingController();
  TextEditingController digestiveDisorders = TextEditingController();
  TextEditingController earNoseThorate = TextEditingController();
  TextEditingController genitoUrinaryReproductive = TextEditingController();
  TextEditingController lifeStyleRelatedProblm = TextEditingController();
  TextEditingController adittionalInformation = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  int val3 = -1;
   bool _isLoading =  false;
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
                            height: 7.5.h,
                            width: 90.w,
                            // color: Colors.purple,
                            child: RichText(
                              text: TextSpan(
                                text:
                                    'If you answered Yes to the previous question, please list any medication you are taking and what they are for.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp),
                              ),
                            ),
                            // Text("Name", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12.sp),) ,
                          ),
                          Container(
                            // height: 15.h,
                            width: 90.w,
                            // margin: EdgeInsets.only(top: 5.sp),
                            // color: Colors.pink,
                            child: TextFormField(
                              controller: anyMedication,
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
                      height: 3.h,
                      width: 90.w,
                      // color: Colors.purple,
                      child: RichText(
                        text: TextSpan(
                          text: 'Do you have any allergies? ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 12.sp),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' (Required)',
                                style: TextStyle(
                                    color: kSignupColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp)),
                          ],
                        ),
                      ),
                      // Text("Name", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12.sp),) ,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 13.sp, right: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 4.h,
                            // color: Colors.blackAccent,
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
                          SizedBox(
                            width: 30.w,
                          ),
                          Container(
                            height: 4.h,
                            // color: Colors.blackAccent,
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
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      height: 8.h,
                      width: 90.w,
                      // color: Colors.purple,
                      child: RichText(
                        text: TextSpan(
                          text: 'Disclaimer: ',
                          style: TextStyle(
                              color: kSignupColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  'If you are pregnant or nursing please check with your doctor before enrolling into this programme.',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.sp),
                            ),
                          ],
                        ),
                      ),
                      // Text("Name", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12.sp),) ,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            height: 5.5.h,
                            width: 90.w,
                            // color: Colors.purple,
                            child: RichText(
                              text: TextSpan(
                                text:
                                    'If you answered Yes to the previous question, please provide details.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp),
                              ),
                            ),
                            // Text("Name", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12.sp),) ,
                          ),
                          Container(
                            // height: 15.h,
                            width: 90.w,
                            // margin: EdgeInsets.only(top: 5.sp),
                            // color: Colors.pink,
                            child: TextFormField(
                              controller: provideDetails,
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
                      child: Column(
                        children: [
                          Container(
                            height: 7.5.h,
                            width: 90.w,
                            // color: Colors.purple,
                            child: Text(
                              "Ailments (please select from the list below; if you have more than one health issue please use the space below to add all the relevant information)",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 11.sp),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 7.h,
                                width: 90.w,
                                // margin: EdgeInsets.only(top: 5.sp),
                                // color: Colors.pink,
                                child: TextFormField(
                                  enabled: false,
                                  controller: moreThanOneHealthIssue,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  // validator: ,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                          width: 0.3.sp,
                                        ),
                                      ),
                                      suffixIcon: Icon(
                                        Icons.arrow_drop_down_sharp,
                                        color: Colors.black,
                                        size: 22.sp,
                                      )),
                                ),
                              ),
                              Container(
                                // height: 7.h,
                                width: 90.w,
                                child: DropdownButton<String>(
                                  underline: Container(),
                                  icon: Container(),
                                  items: <String>[
                                    'Option 1',
                                    'Option 2',
                                    'Option 3',
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      moreThanOneHealthIssue.text = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
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
                            height: 3.h,
                            width: 90.w,
                            // color: Colors.purple,
                            child: Text(
                              "Muscular/Skeletal/Neurological Disorders",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.sp),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 7.h,
                                width: 90.w,
                                // margin: EdgeInsets.only(top: 5.sp),
                                // color: Colors.pink,
                                child: TextFormField(
                                  enabled: false,
                                  controller: muscluarSkeleton,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                          width: 0.3.sp,
                                        ),
                                      ),
                                      suffixIcon: Icon(
                                        Icons.arrow_drop_down_sharp,
                                        size: 22.sp,
                                        color: Colors.black,
                                      )),
                                ),
                              ),
                              Container(
                                // height: 7.h,
                                width: 90.w,
                                child: DropdownButton<String>(
                                  underline: Container(),
                                  icon: Container(),
                                  items: <String>[
                                    'Muscular',
                                    'Skeletal',
                                    'Neurological Disorders',
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      muscluarSkeleton.text = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
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
                            height: 3.h,
                            width: 90.w,
                            // color: Colors.purple,
                            child: Text(
                              "Dermatological Problems",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.sp),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 7.h,
                                width: 90.w,
                                // margin: EdgeInsets.only(top: 5.sp),
                                // color: Colors.pink,
                                child: TextFormField(
                                  enabled: false,
                                  controller: dermotologistProblem,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  // validator: ,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          )),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 0.3.sp,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 0.3.sp,
                                        ),
                                      ),
                                      suffixIcon: Icon(
                                        Icons.arrow_drop_down_sharp,
                                        size: 22.sp,
                                        color: Colors.black,
                                      )),
                                ),
                              ),
                              Container(
                                // height: 7.h,
                                width: 90.w,
                                child: DropdownButton<String>(
                                  underline: Container(),
                                  icon: Container(),
                                  items: <String>[
                                    'Problem 1',
                                    'Problem 2',
                                    'Problem 3',
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      dermotologistProblem.text = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
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
                            height: 3.h,
                            width: 90.w,
                            // color: Colors.purple,
                            child: Text(
                              "Internal Problems",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.sp),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 7.h,
                                width: 90.w,
                                // margin: EdgeInsets.only(top: 5.sp),
                                // color: Colors.pink,
                                child: TextFormField(
                                  enabled: false,
                                  controller: internalProblem,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  // validator: ,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                          width: 0.3.sp,
                                        ),
                                      ),
                                      suffixIcon: Icon(
                                        Icons.arrow_drop_down_sharp,
                                        size: 22.sp,
                                        color: Colors.black,
                                      )),
                                ),
                              ),
                              SizedBox(
                                // height: 7.h,
                                width: 90.w,
                                child: DropdownButton<String>(
                                  underline: Container(),
                                  icon: Container(),
                                  items: <String>[
                                    'Problem 1',
                                    'Problem 2',
                                    'Problem 3',
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      internalProblem.text = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
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
                            height: 3.h,
                            width: 90.w,
                            // color: Colors.purple,
                            child: Text(
                              "Digestive Disorders",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.sp),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 7.h,
                                width: 90.w,
                                // margin: EdgeInsets.only(top: 5.sp),
                                // color: Colors.pink,
                                child: TextFormField(
                                  enabled: false,
                                  controller: digestiveDisorders,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  // validator: ,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                          width: 0.3.sp,
                                        ),
                                      ),
                                      suffixIcon: Icon(
                                        Icons.arrow_drop_down_sharp,
                                        size: 22.sp,
                                        color: Colors.black,
                                      )),
                                ),
                              ),
                              Container(
                                // height: 7.h,
                                width: 90.w,
                                child: DropdownButton<String>(
                                  underline: Container(),
                                  icon: Container(),
                                  items: <String>[
                                    'Disorder 1',
                                    'Disorder 2',
                                    'Disorder 3',
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      digestiveDisorders.text = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
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
                            height: 3.h,
                            width: 90.w,
                            // color: Colors.purple,
                            child: Text(
                              "Ears, Nose, Throat, Eyes & Hair",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.sp),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 7.h,
                                width: 90.w,
                                // margin: EdgeInsets.only(top: 5.sp),
                                // color: Colors.pink,
                                child: TextFormField(
                                  enabled: false,
                                  controller: earNoseThorate,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  // validator: ,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                          width: 0.3.sp,
                                        ),
                                      ),
                                      suffixIcon: Icon(
                                        Icons.arrow_drop_down_sharp,
                                        size: 22.sp,
                                        color: Colors.black,
                                      )),
                                ),
                              ),
                              Container(
                                // height: 7.h,
                                width: 90.w,
                                child: DropdownButton<String>(
                                  underline: Container(),
                                  icon: Container(),
                                  items: <String>[
                                    'Ears',
                                    'Nose',
                                    'Throat',
                                    'Eyes',
                                    'Hair',
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      earNoseThorate.text = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
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
                            height: 3.h,
                            width: 90.w,
                            // color: Colors.purple,
                            child: Text(
                              "Genito-Urinary & Reproductive",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.sp),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 7.h,
                                width: 90.w,
                                // margin: EdgeInsets.only(top: 5.sp),
                                // color: Colors.pink,
                                child: TextFormField(
                                  enabled: false,
                                  controller: genitoUrinaryReproductive,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  // validator: ,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                          width: 0.3.sp,
                                        ),
                                      ),
                                      suffixIcon: Icon(
                                        Icons.arrow_drop_down_sharp,
                                        size: 22.sp,
                                        color: Colors.black,
                                      )),
                                ),
                              ),
                              Container(
                                // height: 7.h,
                                width: 90.w,
                                child: DropdownButton<String>(
                                  underline: Container(),
                                  icon: Container(),
                                  items: <String>[
                                    'Genital Urinary',
                                    'Reproductive',
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      genitoUrinaryReproductive.text = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
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
                            height: 3.h,
                            width: 90.w,
                            // color: Colors.purple,
                            child: Text(
                              "Lifestyle Related Problems",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.sp),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 7.h,
                                width: 90.w,
                                // margin: EdgeInsets.only(top: 5.sp),
                                // color: Colors.pink,
                                child: TextFormField(
                                  enabled: false,
                                  controller: lifeStyleRelatedProblm,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  // validator: ,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                          width: 0.3.sp,
                                        ),
                                      ),
                                      suffixIcon: Icon(
                                        Icons.arrow_drop_down_sharp,
                                        size: 22.sp,
                                        color: Colors.black,
                                      )),
                                ),
                              ),
                              Container(
                                // height: 7.h,
                                width: 90.w,
                                child: DropdownButton<String>(
                                  underline: Container(),
                                  icon: Container(),
                                  items: <String>[
                                    'Problem 1',
                                    'Problem 2',
                                    'Problem 3',
                                    'Problem 4'
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      lifeStyleRelatedProblm.text = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
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
                            height: 3.h,
                            width: 90.w,
                            // color: Colors.purple,
                            child: RichText(
                              text: TextSpan(
                                text: 'Additional Information',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.sp),
                              ),
                            ),
                            // Text("Name", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12.sp),) ,
                          ),
                          Container(
                            // height: 15.h,
                            width: 90.w,
                            // margin: EdgeInsets.only(top: 5.sp),
                            // color: Colors.pink,
                            child: TextFormField(
                              controller: adittionalInformation,
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
                              ),
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
              BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is UserLoggedIn) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubscriptionScreen(),
                      ),
                    );
                  }
                  if (state is LogInError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(showSnackbar(state.error.toString()));
                    // BlocProvider.of<UserBloc>(context).add(InitialStatePush());
                  }
                },
                builder: (context, state) {
                  if (!(state is UserLoading)) {
                    return _isLoading?CircularProgressIndicator(color: kSignupColor,):Container(
                      height: 7.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: ElevatedButton(
                        style: ButtonStyle(   backgroundColor: MaterialStateProperty.all(kSignupColor),shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ) ),

                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate() && val3 != -1) {
                            setState(() {
                              _isLoading= true;
                            });

                            QuestionsAnswr().questionThreeUpload(mediaction: anyMedication.text, pleaseProvideDetails: provideDetails.text, anyAllergies: val3.toString(), relaventInformation: moreThanOneHealthIssue.text, dermotolgist: dermotologistProblem.text, muscularSkel: muscluarSkeleton.text, internalProblmes: internalProblem.text, disgetsiveDisorders: digestiveDisorders.text, earNose: earNoseThorate.text, genoUrinary: genitoUrinaryReproductive.text, lifestyle: lifeStyleRelatedProblm.text, additionalInformation: adittionalInformation.text).then((value) {

setState(() {
  _isLoading=false;
});
                              if(value =="success"){
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) => SubscriptionScreen()));
                              }
                            });
                          } else {
                            print("validation failed");
                            ScaffoldMessenger.of(context).showSnackBar(
                                showSnackbar(
                                    "Please fill all the required fields"));
                          }
                        },
                        child: Text(
                          "Submit Now",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      height: 7.h,
                      width: 90.w,
                      color: Colors.white,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(kSignupColor),
                          // color: theme.primaryColor,
                        ),
                      ),
                    );
                  }
                },
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
