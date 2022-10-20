import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nicotine/Screens/Home%20Screens/components/custom_appbar.dart';
import 'package:nicotine/utils/date_util.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../Constant.dart';
import '../../blocs/Goal/goal_bloc.dart';
import '../../utils/goalHelper.dart';
import '../Components/progressFunction.dart';

class CalenderScreen extends StatefulWidget {
  final bool show_appbar;

  const CalenderScreen({Key? key, required this.show_appbar}) : super(key: key);

  @override
  _CalenderScreenState createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  CalendarFormat cFormat = CalendarFormat.month;
  DateTime focusedDaySelected = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100.h,
        width: 100.w,
        color: Colors.black,
        child: Scaffold(
          extendBody: true,
          // backgroundColor: Colors.white,
          // backgroundColor: Colors.black,
          body: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (widget.show_appbar == true)
                    const CustomAppBar(
                        title: "Calendar", icon: Icons.more_horiz),
                  TableCalendar(
                    onDaySelected: (selectedDay, focusedDay) {
                      focusedDaySelected = selectedDay;
                      setState(() {});
                    },
                    availableCalendarFormats: const {
                      CalendarFormat.month: "Show Month"
                    },
                    calendarFormat: cFormat,
                    onFormatChanged: (CalendarFormat format) {
                      setState(() {
                        cFormat = format;
                      });
                    },
                    calendarStyle: CalendarStyle(
                        defaultTextStyle: TextStyle(color: Colors.black),
                        weekendTextStyle: TextStyle(color: kSignupColor),
                        todayDecoration: BoxDecoration(
                            color: Color(0xffF8DB08),
                            borderRadius: BorderRadius.circular(10))),
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: focusedDaySelected,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    width: 90.w,
                    child: Text(
                      formatterMonDateYear.format(focusedDaySelected),
                      // "25 June, 2021",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  // asdjalkjsd
                  BlocBuilder<GoalBloc, GoalState>(builder: (context, state) {
                    if (state is UserGoalsRetrieved) {
                      return Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: state.goals.map((p) {
                              bool isValidGoal =
                                  isGoalRunning(p, focusedDaySelected);
                              if (isValidGoal) {
                                print(p.goalName!);
                                print(formatterMonDateYear.format(p.goalDate!));
                                return progressFunction(p, context);
                              } else {
                                return Container();
                              }
                            }).toList(),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
