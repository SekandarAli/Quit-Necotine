import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nicotine/blocs/User/user_bloc.dart';
import 'package:nicotine/utils/globals.dart';

import '../../models/User.dart';

class OnBoardingFirestoreService {
  final String collectionName = "user";

  Future<User> createUser(
      String userEmail, String userName, String userPassword) async {
    print("OnBoardingFirestoreService: createUser Function");
    bool emailExists = false;
    await FirebaseFirestore.instance
        .collection(collectionName)
        .where("userEmail", isEqualTo: userEmail)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print("Email exists cannot sign in");
        emailExists = true;
      });
    });

    String userId = DateTime.now().toIso8601String() + "_" + userEmail;
    try {
      if (emailExists) {
        print("Throwing Email already exists");
        throw "Email already exists, please login or enter another email";
      }
      Map<String, dynamic> userMap = {
        "userId": userId,
        "userEmail": userEmail,
        "userName": userName,
        "userPassword": userPassword,
        "userImage":
            "http://4.bp.blogspot.com/-zsbDeAUd8aY/US7F0ta5d9I/AAAAAAAAEKY/UL2AAhHj6J8/s1600/facebook-default-no-profile-pic.jpg",
        "userPoints": 0,
        "userMistakes": [],
        "userQuestionsAsked": false
      };
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(userId)
          .set(userMap)
          .catchError((e) {
        print(e.toString());
      });
      return User(
          userId: userId,
          userEmail: userEmail,
          userName: userName,
          userPassword: userPassword,
          userImage:
              "http://4.bp.blogspot.com/-zsbDeAUd8aY/US7F0ta5d9I/AAAAAAAAEKY/UL2AAhHj6J8/s1600/facebook-default-no-profile-pic.jpg",
          userPoints: 0,
          userMistakes: [],
          userQuestionsAsked: false);
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  Future<User> loginUser(String userEmail, String userPassword) async {
    print("OnBoardingFirestoreService: loginUser Function");
    bool successfulLogin = false;
    bool emailFound = false;
    User user = emptyUser;

    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .where("userEmail", isEqualTo: userEmail)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          emailFound = true;
          print("Email found\nNow checking password");

          if (doc["userPassword"] == userPassword) {
            print("Correct password");
            successfulLogin = true;
            Map<String, dynamic> userMap = {
              "userId": doc["userId"],
              "userEmail": doc["userEmail"],
              "userName": doc["userName"],
              "userPassword": doc["userPassword"],
              "userImage": doc["userImage"],
              "userPoints": doc["userPoints"],
              "userMistakes": doc["userMistakes"],
              "userQuestionsAsked": doc["userQuestionsAsked"]
            };

            user = User.fromJson(userMap);
          } else {
            print("Incorrect password");
            throw "Incorrect password";
          }
        });
      });
      if (!emailFound) {
        print("Email not found");
        throw "Email not found";
      }
      if (!successfulLogin) {
        throw "Something went wrong, please try later.";
      }
      return user;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<User> withOutPasswordLogin(String userId) async {
    print("OnBoardingFirestoreService: withOutPasswordLogin Function");

    bool emailFound = false;
    User user = emptyUser;

    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .where("userId", isEqualTo: userId)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          emailFound = true;
          print("Email found");
          Map<String, dynamic> userMap = {
            "userId": doc["userId"],
            "userEmail": doc["userEmail"],
            "userName": doc["userName"],
            "userPassword": doc["userPassword"],
            "userImage": doc["userImage"],
            "userPoints": doc["userPoints"],
            "userMistakes": doc["userMistakes"],
            "userQuestionsAsked": doc["userQuestionsAsked"]
          };

          user = User.fromJson(userMap);
        });
      });
      if (!emailFound) {
        print("Email not found");
        throw "Email not found";
      }

      return user;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<User> withOutPasswordLoginEmail(String userEmail) async {
    print("OnBoardingFirestoreService: withOutPasswordLogin Function");

    bool emailFound = false;
    User user = emptyUser;

    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .where("userEmail", isEqualTo: userEmail)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          emailFound = true;
          print("Email fkkkkound");

          Map<String, dynamic> userMap = {
            "userId": doc["userId"],
            "userEmail": doc["userEmail"],
            "userName": doc["userName"],
            "userPassword": doc["userPassword"],
            "userImage": doc["userImage"],
            "userPoints": doc["userPoints"],
            "userMistakes": doc["userMistakes"],
            "userQuestionsAsked": doc["userQuestionsAsked"]
          };

          user = User.fromJson(userMap);
        });
      });
      if (!emailFound) {
        print("Email not found");
        throw "Email not found";
      }

      return user;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> checkIfUserEmailExists(String userId) async {
    print("OnBoardingFirestoreService: checkIfUserExists Function");

    bool emailFound = false;
    User user = emptyUser;

    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .where("userEmail", isEqualTo: userId)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          emailFound = true;
          print("Email found");

          Map<String, dynamic> userMap = {
            "userId": doc["userId"],
            "userEmail": doc["userEmail"],
            "userName": doc["userName"],
            "userPassword": doc["userPassword"],
            "userImage": doc["userImage"],
            "userPoints": doc["userPoints"],
            "userMistakes": doc["userMistakes"],
            "userQuestionsAsked": doc["userQuestionsAsked"]
          };

          user = User.fromJson(userMap);
        });
      });
      if (!emailFound) {
        print("Email not found");
        return false;
      }

      return true;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<User> questionsSubmitted(String userId) async {
    print("OnBoardingFirestoreService: questionsSubmitted Function");

    bool emailFound = false;
    User user = emptyUser;

    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .where("userId", isEqualTo: userId)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          emailFound = true;
          print("Email found\nNow checking password");

          print("Correct password");

          Map<String, dynamic> userMap = {
            "userId": doc["userId"],
            "userEmail": doc["userEmail"],
            "userName": doc["userName"],
            "userPassword": doc["userPassword"],
            "userImage": doc["userImage"],
            "userPoints": doc["userPoints"],
            "userMistakes": doc["userMistakes"],
            "userQuestionsAsked": true
          };
          FirebaseFirestore.instance
              .collection(collectionName)
              .doc(doc["userId"])
              .set(userMap)
              .catchError((e) {
            print(e.toString());
          });

          user = User.fromJson(userMap);
        });
      });
      if (!emailFound) {
        print("Email not found");
        throw "Email not found";
      }

      return user;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<User> updateProfile(User user, String email, String fullName,
      String password, String mistake, String userImage) async {
    print("OnBoardingFirestoreService: updateProfile Function");

    user.userMistakes!.add(mistake);
    final image = File(userImage);
    List<int> imageBytes = await image.readAsBytes();

    final base64Image = base64Encode(imageBytes);

    try {
      Map<String, dynamic> userMap = {
        "userId": user.userId,
        "userEmail": email,
        "userName": fullName,
        "userPassword": user.userPassword,
        "userImage": base64Image,
        "userPoints": user.userPoints,
        "userMistakes": user.userMistakes,
        "userQuestionsAsked": user.userQuestionsAsked
      };
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(user.userId)
          .set(userMap)
          .catchError((e) {
        print(e.toString());
      });

      user = User.fromJson(userMap);

      return user;
    } catch (e) {
      throw e.toString();
    }
  }
}
