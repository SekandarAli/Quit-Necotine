// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_for_elements_to_map_fromiterable

import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nicotine/Constant.dart';
import 'package:nicotine/Screens/Components/backButton.dart';
import 'package:nicotine/Screens/Shop%20Screen/models/cart_model.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'provider/cart_provider.dart';
import 'service_checkout.dart';
import 'shop_screen.dart';


class CheckOutScreen extends StatefulWidget {

  var total;


  CheckOutScreen({Key? key,this.total}) : super(key: key);


  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  var  customerId = FirebaseAuth.instance.currentUser!.uid;
  List<Cart> listEmployees = [];
  Cart? cart;
  var box;
  // var myDB;

  @override
  void initState() {
    super.initState();
    getEmployees();
  }



  getEmployees() async {

    // _myDB.getEmployees().then((items){

    box =  Hive.box('cart_model');
    // print(box.length);
    setState(() {
      listEmployees = box.values.toList().cast<Cart>();
      // print(listEmployees.length);
    });
    return listEmployees;
    // });

  }


  cardRow(String text) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        w * 0.05,
        h * 0.0,
        w * 0.08,
        h * 0.0,
      ),
      child: Row(children: [
        Expanded(
            flex: 5,
            child: FittedBox(
                child: Text(text,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)))),
        Expanded(
          flex: 8,
          child: Container(),
        ),
        Expanded(
          flex: 5,
          child: FittedBox(
              child: Text(
                  "\$${widget.total}"
                  , style: TextStyle(color: Colors.black))),
        ),
      ]),
    );
  }
  @override
  Widget build(BuildContext context) {

    final cartProvider = Provider.of<CartProvider>(context);
    var total = cartProvider.getTotalPrice().toStringAsFixed(2);


    var cartBox = Hive.box('cart_model');

    // myDB = getEmployees();
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;


    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: backButton(context),
        backgroundColor: Colors.white,
        title: Text(
          "Check Out",
          style: TextStyle(fontSize: 16.sp, color: Colors.black),
        ),
      ),

      body:
      SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(
                        width: double.infinity,
                        child: FittedBox(
                            child: DataTable(
                                columns: const [
                                  DataColumn(
                                    label: Text(
                                      'Name',
                                      style: TextStyle(
                                          color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                    numeric: true,
                                    tooltip: 'Name of the item',
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Quantity',
                                      style: TextStyle(
                                          color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                    numeric: false,
                                    tooltip: 'Quantity of the item',
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Price',
                                      style: TextStyle(
                                          color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                    numeric: false,
                                    tooltip: 'Price of the item',
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Subtotal',
                                      style: TextStyle(
                                          color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                    numeric: false,
                                    tooltip: 'Subtotal of the item',
                                  ),
                                ],
                                headingTextStyle: const TextStyle(
                                    fontWeight: FontWeight.bold, color: Colors.white), rows: [],
                               )),
                      ),
                      const Divider(
                        thickness: 2,
                        color: Colors.black45,
                      ),


                      Container(
                          height: 150,
                          child:ListView.separated(
                            itemCount: listEmployees.length,
                            itemBuilder: (context, index) {

                              cart = listEmployees[index];

                              return Container(
                                width: double.infinity,
                                padding: EdgeInsets.fromLTRB(
                                  w * 0.05,
                                  h * 0.0,
                                  w * 0.09,
                                  h * 0.0,
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          flex : 2,
                                          child: Text(cart!.productName.toString(),
                                            style: textStyle(),
                                          )),
                                      Expanded(flex: 2, child: Container(),),
                                      Expanded(
                                          flex : 1,
                                          child: Text(cart!.quantity.toString(),
                                            style: textStyle(),
                                          )),
                                      Expanded(flex: 1, child: Container(),),
                                      Expanded(
                                          flex : 1,
                                          child: Text(cart!.productPrice.toString(),
                                            style: textStyle(),
                                          )),
                                      Expanded(flex: 1, child: Container(),),
                                      Expanded(
                                          flex : 1,
                                          child: Text("\$${cart!.productPrice.toString()}",
                                            style: textStyle(),
                                          )),
                                    ]),
                              );
                            }, separatorBuilder: (BuildContext context, int index) {
                            return  Divider(
                              thickness: 2,
                              color: Colors.black45,
                            );
                          },
                          )
                      ),

                      const Divider(
                        thickness: 2,
                        color: Colors.black45,
                      ),

                      cardRow("Total Amount"),
                      const Divider(
                        thickness: 2,
                        color: Colors.black45,
                      ),

                      ElevatedButton(onPressed: () async{



                        Map<dynamic, Map<String,dynamic>> orderCart = Map.fromIterable(

                            listEmployees,
                            key: (Cart) =>
                            Cart.productName,
                            value: (Cart) =>
                            {
                              "ProductName": Cart.productName,
                              "ProductQuantity": Cart.quantity.toString(),
                              "ProductPrice": Cart.productPrice.toString(),
                            }
                        );

                        AuthWithCustomer().placeOrder(

                            // orderId: orderId,
                            customerId: customerId,
                            orderDate: DateTime.now(),
                            orderCashTotal: widget.total,
                            // orderNote: noteTextController.text.toString(),
                            // orderType: orderType == true ? "Cash" : "Card",
                            // orderCardTotal: widget.cardTotal,
                            // orderOption: widget.orderOption,
                            // orderStatus: "Open",
                            orderCart: orderCart
                        ).then((value) {

                        }

                        );

                        var snackBar = SnackBar(content:
                        Text('Order has been Placed and Added to Cart Successfuly'),
                          backgroundColor: Colors.green.shade700,
                          duration: Duration(milliseconds: 2000),);

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        // await Future.delayed(Duration(seconds: 2), () {
                        //   Navigator.push(context,
                        //       MaterialPageRoute(builder: (context){
                        //         return ShopScreen();
                        //       }));
                        //   return Future.value(true);
                        // });

                      }, child: Text("Confirm Order"))
                    ]),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  TextStyle textStyle(){
    return TextStyle(
        color: Colors.black,
        fontSize: 12.sp,
        fontWeight: FontWeight.bold,
        height: 1.5);
  }
}