import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:nicotine/admin_side/models/products_models.dart';
import 'package:nicotine/admin_side/services/storage_methods.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> updateProduct({
    required String description,
    required Uint8List? file,
    required String title,
    required String price,
    required String id,
  }) async {
    String res = "Some error occurred";
    print(res);
    print("men....$id");
    try {
      String photoUrl = await StorageMethods()
          .uploadImageToStorage("productImages", file!, true);
      Products products = Products(
        title: title,
        productImage: photoUrl,
        description: description,
        price: price,
        // uid: productID,
      );

      await _firestore
          .collection('products')
          .doc(id)
          .update(products.toJson())
          .then((value) {
        res = "success";
      });
    } catch (e) {
      print(e.toString());
    }
    return res;
  }

  // Uplaod the products::
  Future<String> uploadProduct(
      {required String description,
      required Uint8List file,
      required String title,
      required String price}) async {
    String res = "Some error occurred";
    try {
      String photoUrl = await StorageMethods()
          .uploadImageToStorage("productImages", file, true);
      // String productID = const Uuid().v1();
      Products products = Products(
        title: title,
        productImage: photoUrl,
        description: description,
        price: price,
        // uid: productID,
      );
      _firestore.collection("products").add(products.toJson());

      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future deleteProduct(String docId) async {
    String? docId;
    String res = "Some error occurred";
    try {
      _firestore.collection('products').doc(docId).delete();

      res = "success";
    } catch (e) {
      print(e.toString());
    }
    throw (e);
  }
}
