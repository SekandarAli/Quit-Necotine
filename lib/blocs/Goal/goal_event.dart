part of 'goal_bloc.dart';

@immutable
abstract class GoalEvent {}

class GetUserGoals extends GoalEvent {}

class AddGoal extends GoalEvent {
  final User? user;
  final String goalName;

  final int goalDays;
  final DateTime goalDate;


  AddGoal({
     this.user,
    required this.goalName,
    required this.goalDays,
    required this.goalDate,

  });
}

class AddGoalToCancelList extends GoalEvent {
  final User user;
  final UserGoal goalToCancel;

  AddGoalToCancelList({
    required this.user,
    required this.goalToCancel,
  });
}

class DeleteAGoal extends GoalEvent {
  final String goalId;

  DeleteAGoal({
    required this.goalId,
  });
}

class ResetGoalState extends GoalEvent {}
