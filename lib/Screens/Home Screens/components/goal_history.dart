import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nicotine/Screens/Components/progressCancelled.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sizer/sizer.dart';

import '../../../Constant.dart';
import '../../../blocs/Goal/goal_bloc.dart';
import '../../../utils/date_util.dart';
import '../../../utils/goalHelper.dart';
import '../../Components/progressFunction.dart';
import '../../my_goals_screen.dart';

class GoalsHistory extends StatelessWidget {
  final int tabKey;
  GoalsHistory({required this.tabKey});
  // const GoalsHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoalBloc, GoalState>(builder: (context, state) {
      if (state is UserGoalsRetrieved) {
        return Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: state.goals.map((p) {
                if (tabKey == 1) {
                  if (p.cancel != true) {
                    return progressFunction(p, context);
                  } else {
                    return Container();
                  }
                } else if (tabKey == 2) {
                  bool isValidGoal = isGoalRunning(p, DateTime.now());
                  if (isValidGoal && p.cancel == false) {
                    print(p.goalName!);
                    print(formatterMonDateYear.format(p.goalDate!));
                    return progressFunction(p, context);
                  } else {
                    return Container();
                  }
                } else if (tabKey == 3) {
                  if (p.cancel == true) {
                    return progressCancelled(p, context);
                  } else {
                    return Container();
                  }
                } else {
                  bool isCompletedGoal = isGoalCompleted(p, DateTime.now());
                  if (isCompletedGoal) {
                    print(p.goalName!);
                    print(formatterMonDateYear.format(p.goalDate!));
                    return progressFunction(p, context);
                  } else {
                    return Container();
                  }
                }
              }).toList(),
            ),
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
