import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:nicotine/Screens/Components/progressFunction.dart';
import 'package:nicotine/Screens/Home%20Screens/goals_screen.dart';
import 'package:nicotine/models/UserGoal.dart';
import 'package:sizer/sizer.dart';

import '../../blocs/Goal/goal_bloc.dart';
import '../../utils/goalHelper.dart';
import '../add_goal_screen.dart';
import 'components/status_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int runningGoals = 0;
  int inProcessGoals = 0;
  int cancelGoals = 0;
  int completeGoals = 0;
  DateTime latestGoalDateTime = DateTime.now();

  void initDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      print(deepLink);
    }
  }

  @override
  void initState() {
    initDynamicLinks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoalBloc, GoalState>(
      builder: (context, state) {
        if (state is UserGoalsRetrieved) {
          runningGoals = 0;
          inProcessGoals = 0;
          cancelGoals = 0;
          completeGoals = 0;
          DateTime latestGoalDateTime = DateTime.now();
          if (state.goals.isNotEmpty) {
            UserGoal latestGoal = state.goals[0];
            latestGoalDateTime =
                latestGoal.goalDate!.add(Duration(days: latestGoal.goalDays!));
          }
          state.goals.forEach((element) {
            if (isGoalInProcess(element, DateTime.now()) &&
                element.cancel != true) {
              inProcessGoals += 1;
            } else if (isGoalCompleted(element, DateTime.now()) &&
                element.cancel != true) {
              completeGoals += 1;
            } else if (isGoalRunning(element, DateTime.now()) &&
                element.cancel != true) {
              runningGoals += 1;
            } else if (element.cancel == true) {
              cancelGoals += 1;
            }
            print(runningGoals);
            print(inProcessGoals);
          });
          return Container(
            height: 100.h,
            width: 100.w,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  height: 14.h,
                  width: 95.w,
                  decoration: BoxDecoration(
                      // color: Colors.yellow,
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.yellow,
                          Colors.green,
                        ],
                      )),
                  child: Center(
                    child: CountdownTimer(
                        endWidget: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddGoalScreen(),
                                  ));
                            },
                            child: Text("Set a Goal",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 25.sp)),
                          ),
                        ),
                        endTime: latestGoalDateTime.millisecondsSinceEpoch,
                        onEnd: () {},
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 25.sp)),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  width: 95.w,
                  child: Text(
                    "My Goals",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  // height: 30.h,
                  // color: Colors.cyanAccent,
                  width: 95.w,
                  child: Table(
                    border: TableBorder.all(color: Colors.white),
                    children: [
                      TableRow(children: [
                        StatusCard(
                          status: "Running",
                          goal: runningGoals.toString(),
                        ),
                        StatusCard(
                          status: "In Progress",
                          goal: inProcessGoals.toString(),
                        ),
                      ]),
                      TableRow(children: [
                        StatusCard(
                          status: "Complete",
                          goal: completeGoals.toString(),
                        ),
                        StatusCard(
                          status: "Cancel",
                          goal: cancelGoals.toString(),
                        ),
                      ])
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  width: 95.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // width: 50.w,
                        child: Text(
                          "Latest Goal ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GoalsScreen(
                                        show_appbar: true,
                                      )));
                        },
                        child: Container(
                          // width: 30.w,
                          child: Text(
                            "See More",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                if (state.goals.isNotEmpty)
                  progressFunction(state.goals[0], context),
                SizedBox(
                  height: 1.h,
                ),
              ]),
            ),
          );
        } else {
          return Container(
            height: 70.h,
            width: 100.w,
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Color(0xff599E48)),
                // color: theme.primaryColor,
              ),
            ),
          );
        }
      },
    );
  }
}
