import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  final String title;
  // final String uid;
  final String price;
  final String description;
  final String productImage;


  Products({
    required this.title,
     // required this.uid,
    required this.price,
    required this.description,
    required this.productImage,

  });

  Map<String, dynamic> toJson() => {
    "title": title,
    // "uid": uid,
    "price": price,
    "description": description,
    "productImage": productImage,

  };

  static Products fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Products(
      title: snapshot["title"],
      description: snapshot["description"],
       // uid: snapshot["uid"],
      price: snapshot["price"],
      productImage: snapshot["productImage"],

    );
  }
}
