import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nicotine/Screens/Components/snackBar.dart';
import 'package:nicotine/models/User.dart' as model;
class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({

    required String username,
    required String email,
    required String password,
  }) async {
    String res = "success";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty
        ) {


        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        model.User user = model.User(
            userId: cred.user!.uid,
            userMistakes: [],
          userName: username,
          userImage:"http://4.bp.blogspot.com/-zsbDeAUd8aY/US7F0ta5d9I/AAAAAAAAEKY/UL2AAhHj6J8/s1600/facebook-default-no-profile-pic.jpg",
          userEmail: email,
            userPoints: 0,
            userPassword: "12345",
            userQuestionsAsked: true,

        );


        await _firestore
            .collection("user")
            .doc(cred.user!.uid).set(user.toJson(user));
        res = "success";
        showSnackbar(res.toString());
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "invalid-email") {
        res = "The email is badly formatted.";
        showSnackbar(res.toString());

      }
      else if (error.code == "weak-password") {
        res = "Your password  should atleast 6 digits";
      } else if(error.code== "ERROR_EMAIL_ALREADY_IN_USE"){
        res = "Email Already Exist.Please use another email";
        showSnackbar(res.toString());
      }



    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //// Login user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occurd";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enters all the feild";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        res = "User not found";
      } else {
        e.code == "wrong-password";
        {
          res = "Password is not correct";
        }
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }


  Future<String> signOut() async {
    String res = "Some error occurd";

    try {
      await FirebaseAuth.instance.signOut();
      res = "success";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    } catch (error) {
      res = error.toString();
    }
    return res;




  }

}




