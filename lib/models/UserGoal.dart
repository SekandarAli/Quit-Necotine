import 'package:nicotine/models/User.dart';

class UserGoal {
  String? goalId;
  String? userId;
  String? goalName;
  // String? goalDescription;
  // String? goalStatus;
  int? goalDays;
  DateTime? goalDate;
  // int? goalTimeSlot;
  bool? running;
  bool? inProcess;
  bool? complete;
  bool? cancel;

  UserGoal({
    required this.goalId,
    required this.userId,
    required this.goalName,
    // required this.goalDescription,
    // required this.goalStatus,
    required this.goalDays,
    required this.goalDate,
    // required this.goalTimeSlot,
    required this.running,
    required this.inProcess,
    required this.complete,
    required this.cancel,
  });

  UserGoal.fromJson(Map<String, dynamic> json) {
    this.goalId = json['goalId'] ?? '';
    this.userId = json['userId'] ?? '';

    this.goalName = json['goalName'] ?? '';
    // this.goalDescription = json['goalDescription'] ?? '';

    // this.goalStatus = json['goalStatus'] ?? '';
    this.goalDays = json['goalDays'] != null ? (json['goalDays']).toInt() : 0;

    this.goalDate = json['goalDate'] != null
        ? DateTime.parse(json['goalDate'])
        : DateTime.now();
    // this.goalTimeSlot =
    //     json['goalTimeSlot'] != null ? (json['goalTimeSlot']).toInt() : 0;

    this.running = json['running'] ?? false;
    this.inProcess = json['inProcess'] ?? false;
    this.complete = json['complete'] ?? false;
    this.cancel = json['cancel'] ?? false;
  }
}
