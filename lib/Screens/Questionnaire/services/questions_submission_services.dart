
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nicotine/Screens/Questionnaire/models/question_screen_1.dart';
import 'package:nicotine/Screens/Questionnaire/models/question_screen_2.dart';
import 'package:nicotine/Screens/Questionnaire/models/question_screen_3.dart';



class QuestionsAnswr {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<String> questionOneUpload({
    required String email,

    required String name,
    required String phone,
    required String height,
    required String country,
    required String city,
    required String weight,
    required String adress,
    required String placeOfBirth,
    required String dateOfBirth,
    required String Gender,
    required String postalCode,
    required String startedSmoke,
    required String streetAdress,
    required String streetAdressLine2,
  }) async {
    String res = "Some error occurred";
    try {
      QuestionScreenOne questionScreenOne = QuestionScreenOne(email: email,
          name: name,
          phone: phone,
          height: height,
          country: country,
          city: city,
          weight: weight,
          adress: adress,
          placeOfBirth: placeOfBirth,
          dateOfBirth: dateOfBirth,
          Gender: Gender,
          postalCode: postalCode,
          startedSmoke: startedSmoke,
          streetAdress: streetAdress,
          streetAdressLine2: streetAdressLine2);
      _firestore.collection("QuestionsAnswer").doc(_auth.currentUser!.uid).collection(
          "QuestionScreenOne").add(
          questionScreenOne.toJson());

      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
   Future<String> questionTwoUpload({
     required String anyDiagnoses,
     required String longestPeroid,
     required String mainReason,
     required String managedStopSmoking,
     required String numberOfCigratte,
     required String startedAgain,
     required String triedStopSmoking,
     required String value1,
     required String value2,
     required String value3,
     required String whyYouSmoke,
  }) async {
    String res = "Some error occurred";
    try {
     QuestionScreenTwo questionScreenTwo = QuestionScreenTwo(anyDiagnoses: anyDiagnoses, longestPeroid: longestPeroid, mainReason: mainReason, managedStopSmoking: managedStopSmoking, numberOfCigratte: numberOfCigratte, startedAgain: startedAgain, triedStopSmoking: triedStopSmoking, value1: value1, value2: value2, value3: value3, whyYouSmoke: whyYouSmoke);
      _firestore.collection("QuestionsAnswer").doc(_auth.currentUser!.uid).collection(
          "QuestionScreenTwo").add(
          questionScreenTwo.toJson());

      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
  ////
  Future<String> questionThreeUpload({
    required String mediaction,
    required String pleaseProvideDetails,
    required String anyAllergies,
    required String relaventInformation,
    required String dermotolgist,
    required String muscularSkel,
    required String internalProblmes,
    required String disgetsiveDisorders,
    required String earNose,
    required String genoUrinary,
    required String lifestyle,
    required String additionalInformation
  }) async {
    String res = "Some error occurred";
    try {
QuestionScreenThree questionScreenThree = QuestionScreenThree(mediaction: mediaction, pleaseProvideDetails: pleaseProvideDetails, anyAllergies: anyAllergies, relaventInformation: relaventInformation, dermotolgist: dermotolgist, muscularSkel: muscularSkel, internalProblmes: internalProblmes, disgetsiveDisorders: disgetsiveDisorders, earNose: earNose, genoUrinary: genoUrinary, lifestyle: lifestyle, additionalInformation: additionalInformation);
      _firestore.collection("QuestionsAnswer").doc(_auth.currentUser!.uid).collection(
          "QuestionScreenThree").add(
          questionScreenThree.toJson());

      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

}
