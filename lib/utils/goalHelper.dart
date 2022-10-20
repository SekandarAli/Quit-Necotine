import 'package:nicotine/utils/date_util.dart';

import '../models/UserGoal.dart';

int getDaysInInt(String goalDays) {
  if (goalDays == "120 Days") {
    return 120;
  } else if (goalDays == "90 Days") {
    return 90;
  } else {
    return 30;
  }
}

int getGoalTimeInInt(String goalTime) {
  if (goalTime == "10 min") {
    return 10;
  } else if (goalTime == "20 min") {
    return 20;
  } else if (goalTime == "30 min") {
    return 30;
  } else if (goalTime == "40 min") {
    return 40;
  } else if (goalTime == "50 min") {
    return 50;
  } else {
    return 60;
  }
}

//  DateTime goalEndDate = DateTime.now().add(Duration(days: goalDays));
//     if (DateTime.now().isAfter(goalDate)) {
//       running = false;
//       inProcess = true;
//       complete = false;
//       cancel = false;
//     } else if (DateTime.now().isBefore(goalDate) &&
//         goalEndDate.isAfter(goalDate)) {
//       running = true;
//       inProcess = false;
//       complete = false;
//       cancel = false;
//     } else if (goalEndDate.isBefore(goalDate)) {
//       running = false;
//       inProcess = false;
//       complete = true;
//       cancel = false;
//     }
//     final Map<String, dynamic> goalMap = {
//       "goalId": goalId,
//       "userId": user.userId,
//       "goalName": goalName,
//       "goalDescription": goalDescription,
//       "goalStatus": goalStatus,
//       "goalDays": goalDays,
//       "goalDate": goalDate.toIso8601String(),
//       "goalTimeSlot": goalTimeSlot,
//       "running": running,
//       "inProcess": inProcess,
//       "complete": complete,
//       "cancel": cancel,
//     };

bool isGoalRunning(UserGoal goal, DateTime currentDate) {
  // print(goal.goalDays!);
  DateTime goalEndDate = goal.goalDate!.add(Duration(days: goal.goalDays!));
  // print(formatterMonDateYear.format(goal.goalDate!));
  // print(formatterMonDateYear.format(goalEndDate));
  // if (DateTime.now().day == currentDate.day &&
  //     DateTime.now().month == currentDate.month &&
  //     DateTime.now().year == currentDate.year) {
  //   return true;
  // }
  // if (currentDate.isAtSameMomentAs(goal.goalDate!) &&
  //     currentDate.isBefore(goalEndDate)) {
  //   return true;
  // }

  if ((currentDate.isAfter(goal.goalDate!) && currentDate.isBefore(goalEndDate))
      //     ||
      // (DateTime.now().day == currentDate.day &&
      //     DateTime.now().month == currentDate.month &&
      //     DateTime.now().year == currentDate.year)
      ) {
    return true;
  } else {
    return false;
  }
}

bool isGoalCompleted(UserGoal goal, DateTime currentDate) {
  DateTime goalEndDate = goal.goalDate!.add(Duration(days: goal.goalDays!));

  if (currentDate.isAfter(goalEndDate)) {
    return true;
  } else {
    return false;
  }
}

bool isGoalInProcess(UserGoal goal, DateTime currentDate) {
  if (goal.goalDate!.isAfter(currentDate)) {
    return true;
  } else {
    return false;
  }
}

int goalPercentage(UserGoal goal, DateTime currentDate) {
  DateTime goalEndDate = goal.goalDate!.add(Duration(days: goal.goalDays!));
  if ((currentDate.isAfter(goal.goalDate!) && currentDate.isBefore(goalEndDate))
      //     ||
      // (DateTime.now().day == currentDate.day &&
      //     DateTime.now().month == currentDate.month &&
      //     DateTime.now().year == currentDate.year)
      ) {
    int completedDays = currentDate.difference(goal.goalDate!).inDays;
    int totalDays = goal.goalDays!;
    int percent = (completedDays / totalDays * 100).toInt();
    // print(currentDate.difference(goal.goalDate!).inDays);
    if (percent > 0) {
      return percent;
    } else {
      return 0;
    }
  } else if (goalEndDate.isBefore(currentDate)) {
    return 100;
  } else {
    return 0;
  }
}

int numberDay(DateTime creationDate, DateTime firstCreationDate) {
  int currentDay = 1;
  currentDay = creationDate.difference(firstCreationDate).inDays + 1;
  return currentDay;
}
