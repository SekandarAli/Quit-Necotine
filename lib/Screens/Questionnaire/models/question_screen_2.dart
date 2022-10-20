class QuestionScreenTwo {
  final String mainReason;

  final String triedStopSmoking;
  final String longestPeroid;
  final String managedStopSmoking;
  final String startedAgain;
  final String numberOfCigratte;
  final String whyYouSmoke;
  final String value1;
  final String value2;
  final String value3;
  final String anyDiagnoses;

  QuestionScreenTwo({required this.anyDiagnoses, required this.longestPeroid, required this.mainReason, required this.managedStopSmoking, required this.numberOfCigratte, required this.startedAgain, required this.triedStopSmoking, required this.value1, required this.value2, required this.value3, required this.whyYouSmoke});
  Map<String, dynamic> toJson() => {
    "mainReason": mainReason,
    "triedStopSmoking": triedStopSmoking,
    "longestPeroid": longestPeroid,
    "managedStopSmoking": managedStopSmoking,
    "startedAgain": startedAgain,
    "numberOfCigratte": numberOfCigratte,
    "whyYouSmoke": whyYouSmoke,
    "value1": value1,
    "value2": value2,
    "value3": value3,
    "anyDiagnoses": anyDiagnoses,

  };

}
