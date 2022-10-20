import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nicotine/resources/firebase_services/OnBoardingFirestoreService.dart';

import '../../models/User.dart';
import '../../resources/providers/LoginProvider.dart';
import '../../utils/local_storage.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());
  final onBoardingFirestoreService = OnBoardingFirestoreService();

  @override
  Stream<UserState> mapEventToState(
      UserEvent event,
      ) async* {
    if (event is InitialStatePush) {
      yield UserInitial();
    } else if (event is CheckIfLoggedIn) {
      yield UserSplashScreen();
      try {
        print("Inside Check if Logged in");
        if (Storage.getValue("userId") == null ||
            Storage.getValue("userId") == "null") {
          print('Not Logged In, key not found');
          yield UserInitial();
        } else {
          print('pref key found');
          final userId = Storage.getValue("userId");

          final user =
          await onBoardingFirestoreService.withOutPasswordLogin(userId!);

          yield UserLoggedIn(user: user);
        }
      } catch (e) {
        print('Error');
        print(e.toString());
        yield UserInitial();
      }
    } else if (event is GoogleLogin) {
      yield UserLoading();
      try {
        print("UserBloc: GoogleLogin event");

        Map<String, dynamic> googleCreds =
        await loginViaGoogle() as Map<String, dynamic>;
        print("Inside google login event: ${googleCreds}");
        if (googleCreds["email"] == null) {
          throw "Google Creds not found";
        }

        final boolUserExists = await onBoardingFirestoreService
            .checkIfUserEmailExists(googleCreds["email"]);

        if (boolUserExists) {
          final user = await onBoardingFirestoreService
              .withOutPasswordLoginEmail(googleCreds["email"]);

          if ((user.userQuestionsAsked!) == false) {
            yield UserShowQuestions(user: user);
          } else {
            Storage.setValue("userId", user.userId!);

            yield UserLoggedIn(user: user);
          }
        } else {
          User user = await onBoardingFirestoreService.createUser(
              googleCreds["email"], googleCreds["first_name"], "1234");

          if ((user.userQuestionsAsked!) == false) {
            yield UserShowQuestions(user: user);
          } else {
            Storage.setValue("userId", user.userId!);

            yield UserLoggedIn(user: user);
          }
        }
      } catch (e) {
        print('error in Signup');
        yield LogInError(error: e.toString());
      }
    } else if (event is FacebookLogin) {
      yield UserLoading();
      try {
        print("UserBloc: GoogleLogin event");

        Map<String, dynamic> facebookCreds =
        await loginViaGoogle() as Map<String, dynamic>;
        print("Inside facebook login event: ${facebookCreds}");
        if (facebookCreds["email"] == null) {
          throw "Google Creds not found";
        }

        final boolUserExists = await onBoardingFirestoreService
            .checkIfUserEmailExists(facebookCreds["email"]);

        if (boolUserExists) {
          final user = await onBoardingFirestoreService
              .withOutPasswordLoginEmail(facebookCreds["email"]);

          if ((user.userQuestionsAsked!) == false) {
            yield UserShowQuestions(user: user);
          } else {
            Storage.setValue("userId", user.userId!);

            yield UserLoggedIn(user: user);
          }
        } else {
          User user = await onBoardingFirestoreService.createUser(
              facebookCreds["email"], facebookCreds["first_name"], "1234");

          if ((user.userQuestionsAsked!) == false) {
            yield UserShowQuestions(user: user);
          } else {
            Storage.setValue("userId", user.userId!);

            yield UserLoggedIn(user: user);
          }
        }
      } catch (e) {
        print('error in Signup');
        yield LogInError(error: e.toString());
      }
    } else if (event is SignUp) {
      yield UserLoading();

      try {
        print("UserBloc: SignUp event");

        User user = await onBoardingFirestoreService.createUser(
            event.email, event.fullName, event.password);

        if ((user.userQuestionsAsked!) == false) {
          yield UserShowQuestions(user: user);
        } else {
          Storage.setValue("userId", user.userId!);

          yield UserLoggedIn(user: user);
        }
      } catch (e) {
        print('error in Signup');
        yield LogInError(error: e.toString());
      }
    } else if (event is SignIn) {
      yield UserLoading();
      try {
        print("UserBloc: SignIn event");

        User user = await onBoardingFirestoreService.loginUser(
            event.email, event.password);
        if ((user.userQuestionsAsked!) == false) {
          yield UserShowQuestions(user: user);
        } else {
          Storage.setValue("userId", user.userId!);

          yield UserLoggedIn(user: user);
        }
      } catch (e) {
        print('error in Signup');
        yield LogInError(error: e.toString());
      }
    } else if (event is QuestionsSubmitted) {
      yield UserLoading();
      try {
        print("UserBloc: QuestionsSubmitted event");

        User user =
        await onBoardingFirestoreService.questionsSubmitted(event.userId);

        Storage.setValue("userId", user.userId!);

        yield UserLoggedIn(user: user);
      } catch (e) {
        print('error in Signup');
        yield LogInError(error: e.toString());
      }
    } else if (event is UpdateProfile) {
      try {
        print("UserBloc: UpdateProfile event");

        User user = await onBoardingFirestoreService.updateProfile(
            event.user,
            event.email,
            event.fullName,
            event.password,
            event.mistake,
            event.userImage);

        yield UserLoggedIn(user: user);
      } catch (e) {
        print('error in Signup');
        yield LogInError(error: e.toString());
      }
    } else if (event is Logout) {
      print("UserBloc: Logout event");
      Storage.setValue('userId', 'null');
      yield UserInitial();
    }
  }
}
