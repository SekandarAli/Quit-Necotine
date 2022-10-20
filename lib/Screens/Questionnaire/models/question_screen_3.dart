class QuestionScreenThree {
  final String mediaction;

  final String anyAllergies;
  final String pleaseProvideDetails;
  final String relaventInformation;
  final String muscularSkel;
  final String dermotolgist;
  final String internalProblmes;
  final String disgetsiveDisorders;
  final String earNose;
  final String genoUrinary;
  final String lifestyle;
  final String additionalInformation;

  QuestionScreenThree({required this.mediaction, required this.pleaseProvideDetails, required this.anyAllergies, required this.relaventInformation, required this.dermotolgist, required this.muscularSkel, required this.internalProblmes, required this.disgetsiveDisorders, required this.earNose, required this.genoUrinary, required this.lifestyle, required this.additionalInformation, });
  Map<String, dynamic> toJson() => {
    "mediaction": mediaction,
    "anyAllergies": anyAllergies,
    "pleaseProvideDetails": pleaseProvideDetails,
    "relaventInformation": relaventInformation,
    "muscularSkel": muscularSkel,
    "dermotolgist": dermotolgist,
    "internalProblmes": internalProblmes,
    "disgetsiveDisorders": disgetsiveDisorders,
    "earNose": earNose,
    "genoUrinary": genoUrinary,
    "lifestyle": lifestyle,
    "additionalInformation":additionalInformation,

  };

}
