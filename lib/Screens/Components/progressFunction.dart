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

Widget progressFunction(UserGoal userGoal, BuildContext context) {
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      BlocListener<GoalBloc, GoalState>(
                          listener: (context, goalState) {
                            if (goalState is GoalAdded) {
                              Navigator.of(context).pop();
                              BlocProvider.of<GoalBloc>(context)
                                  .add(GetUserGoals());
                            }
                          },
                          child: GestureDetector(
                              onTap: () {
                                learnMoreDialogBox(
                                    context: context,
                                    heading: 'Delete Goal',
                                    content: 'Do you want to delete this goal?',
                                    buttonText: "Delete Goal",
                                    function: () {
                                      final userState =
                                          BlocProvider.of<UserBloc>(context)
                                              .state;
                                      if (userState is UserLoggedIn) {
                                        BlocProvider.of<GoalBloc>(context).add(
                                            AddGoalToCancelList(
                                                user: userState.user,
                                                goalToCancel: userGoal));
                                        BlocProvider.of<GoalBloc>(context).add(
                                            DeleteAGoal(
                                                goalId: userGoal.goalId!));
                                      } else {
                                        print("Something went wrong");
                                      }

                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => UploadPostScreen(
                                      //             isEditPost: false,
                                      //           )),
                                      // );

                                      // final userState =
                                      //     BlocProvider.of<UserBloc>(context).state;
                                      // if (userState is UserLoggedIn) {
                                      //   print("creating a post");
                                      //   BlocProvider.of<ForumBloc>(context).add(CreateAPost(
                                      //     user: User(
                                      //         userId: userState.user.userId,
                                      //         userEmail: userState.user.userEmail,
                                      //         userName: userState.user.userName,
                                      //         userPassword: userState.user.userPassword,
                                      //         userImage: userState.user.userImage,
                                      //         userPoints: userState.user.userPoints,
                                      //         userMistakes: userState.user.userMistakes,
                                      //         userQuestionsAsked:
                                      //             userState.user.userQuestionsAsked),
                                      //     postDescription: "Welcome",
                                      //     postImage:
                                      //         "https://images.unsplash.com/photo-1592743263126-bb241ee76ac7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YmVhdXRpZnVsJTIwc2NlbmVyeXxlbnwwfHwwfHw%3D&w=1000&q=80",
                                      //   ));
                                      //   // "https://images.unsplash.com/photo-1592743263126-bb241ee76ac7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YmVhdXRpZnVsJTIwc2NlbmVyeXxlbnwwfHwwfHw%3D&w=1000&q=80")),
                                    });
                              },
                              child: Icon(
                                Icons.delete,
                                size: 18.sp,
                                color: Colors.black,
                              ))),
                      //   Navigator.of(context).pop();
                      // } else {
                      //   Navigator.of(context).pop();
                      //   ScaffoldMessenger.of(context)
                      //       .showSnackBar(showSnackbar("Please login to post"));
                      // }

                      Text(
                        "150 Points",
                        style: TextStyle(
                            color: kSigninColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp),
                      ),
                    ],
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
