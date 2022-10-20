part of 'activity_bloc.dart';

@immutable
abstract class ActivityState {}

class ActivityInitial extends ActivityState {}

class UserActivitiesRetrieved extends ActivityState {
  final List<UserActivity> activities;
  UserActivitiesRetrieved({
    required this.activities,
  });
}

class ActivityAdded extends ActivityState {}

class ActivityError extends ActivityState {
  final String error;
  ActivityError({required this.error});
}
