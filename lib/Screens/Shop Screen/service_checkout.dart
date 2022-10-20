import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nicotine/Screens/Shop%20Screen/models/order_model.dart';

class AuthWithCustomer {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<String> placeOrder({

    // required orderId,
    customerId,
    required orderDate,
    required orderCashTotal,
    // orderNote,
    // orderType,
    // required orderCardTotal,
    // orderOption,
    // orderStatus,
    orderCart,
  }) async {
    String res = "Some error occurred";
    try {

      OrderModel orderModel = OrderModel(
        // orderId: orderId,
        customerId: customerId,
        orderDate: orderDate,
        orderCashTotal: orderCashTotal,
        // orderNote: orderNote,
        // orderType: orderType,
        // orderCardTotal: orderCardTotal,
        // orderOption: orderOption,
        // orderStatus: orderStatus,
        orderCart: orderCart,
      );

      var encodedObject = json.encode(orderCart);

      _fireStore.collection("Order").add(orderModel.toJson());


      // _fireStore.collection("Order").doc(auth.currentUser!.uid).set({
      //   "orderCart" : FieldValue.arrayUnion([
      //     encodedObject
      //   ])
      // },SetOptions(merge: true));


      res = "success";
      print("ressss$res");
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
