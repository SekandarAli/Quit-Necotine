import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nicotine/Screens/Components/backButton.dart';
import 'package:nicotine/Screens/Home%20Screens/dash_bord.dart';

import 'package:nicotine/blocs/Goal/goal_bloc.dart';
import 'package:nicotine/utils/date_util.dart';
import 'package:sizer/sizer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../Constant.dart';
import '../blocs/User/user_bloc.dart';
import '../utils/goalHelper.dart';
import 'Components/snackBar.dart';

class AddGoalScreen extends StatefulWidget {
  const AddGoalScreen({Key? key}) : super(key: key);

  @override
  _AddGoalScreenState createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  TextEditingController goal_name_1 = TextEditingController();
  TextEditingController goal_name_2 = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime addedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  String? selectedValue;
  List<String> items = [
    '120 Days',
    '90 Days',
    '30 Days',
  ];

  @override
  void initState() {
    dateController.text = formatterMonDateYear.format(addedDate);
    super.initState();
  }

  var userState;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(CheckIfLoggedIn()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          leading: backButton(context),
          backgroundColor: Colors.white,
          title: Text(
            "Add Goal",
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 6.h,
                      ),
                      Container(
                        // height: 7.h,
                        width: 90.w,
                        margin: EdgeInsets.only(top: 3.h),
                        // color: Colors.pink,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter goal name';
                            }

                            return null;
                          },
                          controller: goal_name_1,
                          cursorColor: Colors.black,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          maxLines: 1,
                          // validator: ,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Goal Name",
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
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
                                "assets/Work.png",
                                color: kSignupColor,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 7.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 0.6.sp, color: kSignupColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 2.w, right: 1.w),
                        child: Image.asset(
                          "assets/Calendar.png",
                          color: kSignupColor,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Text(
                                'Choose Days',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                                overflow: TextOverflow.ellipsis,
                              ),
                              items: items
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as String;
                                });
                              },
                              icon: const Icon(
                                Icons.arrow_drop_down,
                              ),
                              iconSize: 30,
                              iconEnabledColor: Colors.black,
                              iconDisabledColor: Colors.black,
                              buttonHeight: 50,
                              buttonWidth: 160,
                              buttonPadding:
                                  const EdgeInsets.only(left: 8, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // border: Border.all(
                                //   color: kSignupColor,
                                // ),
                                color: Colors.white,
                              ),
                              buttonElevation: 0,
                              itemHeight: 40,
                              itemPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              dropdownMaxHeight: 200,
                              dropdownWidth: 30.w,
                              dropdownPadding: null,
                              dropdownDecoration: BoxDecoration(
                                border:
                                    Border.all(color: kSignupColor, width: 1.3),
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.white,
                              ),
                              dropdownElevation: 8,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 6,
                              scrollbarAlwaysShow: true,
                              offset: const Offset(180, 20),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (_) => Container(
                            height: 250,
                            color: Color.fromARGB(255, 255, 255, 255),
                            child: Column(children: [
                              Container(
                                height: 240,
                                child: CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.date,
                                    minimumDate: DateTime.now()
                                        .subtract(Duration(minutes: 1)),
                                    initialDateTime: DateTime.now(),
                                    maximumDate: DateTime(2080, 12, 31, 0, 0),
                                    onDateTimeChanged: (val) {
                                      setState(() {
                                        addedDate = val;
                                        dateController.text =
                                            formatterMonDateYear
                                                .format(addedDate);
                                      });
                                    }),
                              )
                            ])));
                  },
                  child: Container(
                    height: 7.h,
                    width: 90.w,
                    margin: EdgeInsets.only(top: 3.h),
                    // color: Colors.pink,
                    child: TextFormField(
                      enabled: false,
                      controller: dateController,
                      cursorColor: Colors.black,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 1,
                      // validator: ,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Choose Your Date",
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                        // contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 0.6,
                              color: kSignupColor,
                            )),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: kSignupColor,
                            width: 0.5.sp,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: kSignupColor,
                            width: 0.5.sp,
                          ),
                        ),
                        prefixIcon: Image.asset(
                          "assets/Calendar.png",
                          color: kSignupColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                SizedBox(
                  height: 7.h,
                ),
                BlocConsumer<GoalBloc, GoalState>(
                  listener: (context, state) {
                    if (state is GoalAdded) {
                      BlocProvider.of<GoalBloc>(context).add(ResetGoalState());
                    }
                    if (state is GoalInitial) {
                      BlocProvider.of<GoalBloc>(context).add(GetUserGoals());
                      Navigator.of(context).pop();
                    }
                  },
                  builder: (context, state) {
                    return Container(
                      height: 7.h,
                      width: 65.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(kSignupColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                        ),
                        onPressed: () async{
                          if (_formKey.currentState!.validate()) {
                            print("First Time");
                            // if (dateController.text.isNotEmpty ||
                            //     addedDate != null ||
                            //     selectedValue != null
                            //
                            // ) {
                            userState = BlocProvider.of<UserBloc>(context).state;
                            // userState = UserLoggedIn(user: userState);
                            print("aaa${userState}");
                            print("second time ");

                            // if (userState is UserLoggedIn) {
                            // if (userState is UserInitail) {
                            if (userState is UserLoggedIn) {
                              print("aaa${userState}");
                               BlocProvider.of<GoalBloc>(context).add(AddGoal(
                                user: userState.user,
                                goalName: goal_name_1.text,
                                goalDays: getDaysInInt(selectedValue!),
                                goalDate: addedDate,
                              ));

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DashBord(),
                                  ));
                            }
                          // } else {
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                showSnackbar("Please enter all the details"));
                          }

                          // }

                          // else {
                          //   print("Error in Validation");
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //       showSnackbar("Please enter all the details"));
                          // }
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentsScreen(),),);
                        },
                        child: Text(
                          "Create Goal",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
