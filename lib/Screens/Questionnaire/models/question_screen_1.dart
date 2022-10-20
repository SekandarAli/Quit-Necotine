import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionScreenOne {
  final String name;

  final String adress;
  final String streetAdress;
  final String streetAdressLine2;
  final String city;
  final String country;
  final String postalCode;
  final String email;
   final String  phone;
   final String dateOfBirth;
   final String placeOfBirth;
   final String Gender;
   final String height;
   final String weight;
   final String startedSmoke;

  QuestionScreenOne({
   required this.email,
    required this.name,
    required this.phone,
    required this.height,
    required this.country,
    required  this.city,
    required this.weight,
    required this.adress,
    required this.placeOfBirth,
    required this.dateOfBirth,
    required this.Gender,
    required this.postalCode, required this.startedSmoke,
    required this.streetAdress,required this.streetAdressLine2

  });

  Map<String, dynamic> toJson() => {
    "email": email,
    "name": name,
    "phone": phone,
    "height": height,
    "country": country,
    "city": city,
    "weight": weight,
    "adress": adress,
    "placeOfBirth": placeOfBirth,
    "dateOfBirth": dateOfBirth,
    "Gender": Gender,
    "postalCode": postalCode,
    "adress": startedSmoke,
    "placeOfBirth": streetAdress,
    "dateOfBirth": streetAdressLine2,

  };

}
