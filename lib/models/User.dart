class User {
  String? userId;
  String? userEmail;
  String? userName;
  String? userPassword;
  String? userImage;
  int? userPoints;
  List<String>? userMistakes;
  bool? userQuestionsAsked;

  User(
      {required this.userId,
      required this.userEmail,
      required this.userName,
      required this.userPassword,
      required this.userImage,
      required this.userPoints,
      required this.userMistakes,
      required this.userQuestionsAsked});

  User.fromJson(Map<String, dynamic> json) {
    this.userId = json['userId'] ?? "";
    this.userEmail = json['userEmail'] ?? "";
    this.userName = json['userName'] ?? "";
    this.userPassword = json['userPassword'] ?? "";
    this.userImage = json['userImage'] ?? "";
    this.userPoints =
        json['userPoints'] != null ? (json['userPoints']).toInt() : 0;
    final allUserMistakes = json['userMistakes'];

    List<String> allMistakes = [];
    if (allUserMistakes != null)
      allUserMistakes.forEach((e) {
        allMistakes.add(e);
      });
    this.userMistakes = allMistakes;

    this.userQuestionsAsked = json['userQuestionsAsked'] ?? false;
  }

  Map<String, dynamic> toJson(User user) {
    Map<String, dynamic> userMap = {
      "userId": user.userId,
      "userEmail": user.userEmail,
      "userName": user.userName,
      "userPassword": user.userPassword,
      "userImage": user.userImage,
      "userPoints": user.userPoints,
      "userMistakes": user.userMistakes,
      "userQuestionsAsked": user.userQuestionsAsked
    };
    return userMap;
  }
}
