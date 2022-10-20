
import 'dart:convert';

List<OrderModel> modelDataFromMap(String str) =>
    List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String modelDataToMap(List<OrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel{

  // String orderId;
  String? customerId;
  DateTime orderDate;
  // String? orderName;
  // int? orderQuantity;
  // String? orderPrice;
  String orderCashTotal;
  // String orderCardTotal;
  // String? orderNote;
  // String? orderType;
  // String? orderOption;
  // String? orderStatus;
  // List<Cart>? orderCart = [];
  // Map<String, List> orderCart;
  // Map<Map<String,dynamic>, Map<String,dynamic>> orderCart;
  var orderCart;

  OrderModel(
      {
        // required this.orderId,
       this.customerId,
      required this.orderDate,
       // this.orderName,
       // this.orderQuantity,
       // this.orderPrice,
      required this.orderCashTotal,
      // required this.orderCardTotal,
      //  this.orderNote,
      //  this.orderType,
      //  this.orderOption,
      //  this.orderStatus,
       required this.orderCart
      });

  Map<String, dynamic> toJson() {
    return {
      // 'orderId': this.orderId,
      'customerId': this.customerId,
      'orderDate': this.orderDate,
      // 'orderName': this.orderName,
      // 'orderQuantity': this.orderQuantity,
      // 'orderPrice': this.orderPrice,
      'orderCashTotal': this.orderCashTotal,
      // 'orderCardTotal': this.orderCardTotal,
      // 'orderNote': this.orderNote,
      // 'orderType': this.orderType,
      // 'orderOption': this.orderOption,
      // 'orderStatus': this.orderStatus,
      'orderCart': this.orderCart,
    };
  }

   OrderModel.fromJson(Map<String, dynamic> map) :
      // orderId =  map['orderId'],
      customerId =  map['customerId'],
      orderDate =  map['orderDate'],
      // orderName =  map['orderName'],
      // orderQuantity =  map['orderQuantity'],
      // orderPrice = map['orderPrice'],
      orderCashTotal = map['orderCashTotal'],
      // orderCardTotal =  map['orderCardTotal'],
      // orderNote =  map['orderNote'],
      // orderType =  map['orderType'],
      // orderOption =  map['orderOption'],
      // orderStatus =  map['orderStatus'],
      orderCart =  map['orderCart'];
}