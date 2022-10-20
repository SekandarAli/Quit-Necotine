part of 'goal_bloc.dart';

@immutable
abstract class GoalState {}

class GoalInitial extends GoalState {}

class UserGoalsRetrieved extends GoalState {
  final List<UserGoal> goals;
  UserGoalsRetrieved({
    required this.goals,
  });
}

class GoalAdded extends GoalState {}

class GoalError extends GoalState {
  final String error;
  GoalError({required this.error});
}
