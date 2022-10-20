part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class InitialStatePush extends UserEvent {}

class CheckIfLoggedIn extends UserEvent {}

class GoogleLogin extends UserEvent {}

class FacebookLogin extends UserEvent {}

class SignIn extends UserEvent {
  final String email, password;
  SignIn({required this.email, required this.password});
}

class SignUp extends UserEvent {
  final String email, fullName, password;

  SignUp({
    required this.email,
    required this.fullName,
    required this.password,
  });
}

class UpdateProfile extends UserEvent {
  final User user;
  final String email, fullName, password, mistake, userImage;

  UpdateProfile({
    required this.user,
    required this.email,
    required this.fullName,
    required this.password,
    required this.mistake,
    required this.userImage,
  });
}

class QuestionsSubmitted extends UserEvent {

  final String userId;

  QuestionsSubmitted({required this.userId});
}

class Logout extends UserEvent {}
