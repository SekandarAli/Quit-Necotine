part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSplashScreen extends UserState {}

class UserShowQuestions extends UserState {
  final User user;
  UserShowQuestions({required this.user});
}

class UserLoggedIn extends UserState {
  final User user;

  UserLoggedIn({required this.user});


}

class LogInError extends UserState {
  final String error;
  LogInError({required this.error});
}
