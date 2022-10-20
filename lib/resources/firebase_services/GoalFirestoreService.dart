import 'package:cloud_firestore/cloud_firestore.dart';


import '../../models/User.dart';
import '../../models/UserGoal.dart';
import '../../utils/local_storage.dart';

class GoalFirestoreService {
  final String collectionName = "goal";
  final String cancelCollectionName = "cancelGoal";

  Future<bool> createGoal(
      User user,
      String goalName,
      int goalDays,
      DateTime goalDate,
      ) async {
    print("GoalFirestoreService: createGoal Function");
    String goalId = DateTime.now().toIso8601String() + "_" + user.userEmail!;
    try {
      bool running = false, inProcess = false, complete = false, cancel = false;
      DateTime goalEndDate = DateTime.now().add(Duration(days: goalDays));
      if (DateTime.now().isAfter(goalDate)) {
        running = false;
        inProcess = true;
        complete = false;
        cancel = false;
      } else if (DateTime.now().isBefore(goalDate) &&
          goalEndDate.isAfter(goalDate)) {
        running = true;
        inProcess = false;
        complete = false;
        cancel = false;
      } else if (goalEndDate.isBefore(goalDate)) {
        running = false;
        inProcess = false;
        complete = true;
        cancel = false;
      }
      final Map<String, dynamic> goalMap = {
        "goalId": goalId,
        "userId": user.userId,
        "goalName": goalName,
        // "goalDescription": goalDescription,
        // "goalStatus": goalStatus,
        "goalDays": goalDays,
        "goalDate": goalDate.toIso8601String(),
        // "goalTimeSlot": goalTimeSlot,
        "running": running,
        "inProcess": inProcess,
        "complete": complete,
        "cancel": cancel,
      };
      FirebaseFirestore.instance
          .collection(collectionName)
          .doc(goalId)
          .set(goalMap)
          .catchError((e) {
        print(e.toString());
      });

      return true;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> addToCancelGoal(User user, UserGoal goal) async {
    print("GoalFirestoreService: addToCancelGoal Function");

    try {
      final Map<String, dynamic> goalMap = {
        "goalId": goal.goalId,
        "userId": user.userId,
        "goalName": goal.goalName,
        "goalDays": goal.goalDays,
        "goalDate": goal.goalDate!.toIso8601String(),
        "running": goal.running,
        "inProcess": goal.inProcess,
        "complete": goal.complete,
        "cancel": true,
      };
      FirebaseFirestore.instance
          .collection(cancelCollectionName)
          .doc(goal.goalId)
          .set(goalMap)
          .catchError((e) {
        print(e.toString());
      });

      return true;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<UserGoal>> getAllUserGoals() async {
    print("GoalFirestoreService: getAllUserGoals Function");
    try {
      var map = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc()
          .snapshots();
      CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection(collectionName);

      QuerySnapshot querySnapshot = await _collectionRef.get();

      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();

      print(allData);

      List<UserGoal> allGoals = [];
      allData.forEach((item) {
        final affirm = item as Map<String, dynamic>;
        if (affirm["userId"] == Storage.getValue("userId")) {
          allGoals.add(UserGoal.fromJson(affirm));
        }
      });

      var mapTwo = await FirebaseFirestore.instance
          .collection(cancelCollectionName)
          .doc()
          .snapshots();
      CollectionReference _collectionRefTwo =
      FirebaseFirestore.instance.collection(cancelCollectionName);

      QuerySnapshot querySnapshotTwo = await _collectionRefTwo.get();
      final allDataTwo = querySnapshotTwo.docs.map((doc) {
        return doc.data();
      }).toList();

      print(allDataTwo);

      allDataTwo.forEach((item) {
        final affirm = item as Map<String, dynamic>;
        if (affirm["userId"] == Storage.getValue("userId")) {
          allGoals.add(UserGoal.fromJson(affirm));
        }
      });

      print("All Goals: ${allGoals.length}");

      return allGoals.reversed.toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> deleteGoal(String goalId) async {
    print("GoalFirestoreService: deleteGoal Function");
    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(goalId)
          .delete();

      return true;
    } catch (e) {
      throw e.toString();
    }
  }
}
