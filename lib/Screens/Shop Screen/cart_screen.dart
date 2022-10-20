// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nicotine/Constant.dart';
import 'package:nicotine/Screens/Components/backButton.dart';
import 'package:nicotine/Screens/Shop%20Screen/checkout.dart';
import 'package:nicotine/Screens/Shop%20Screen/models/cart_model.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'provider/cart_provider.dart';


class CartNewScreen extends StatefulWidget {


  CartNewScreen({Key? key}) : super(key: key);


  @override
  State<CartNewScreen> createState() => _CartNewScreenState();
}

class _CartNewScreenState extends State<CartNewScreen> {
  String? customerId;

  List<Cart> listEmployees = [];
  // Cart? cart;
  var box;
  var myDB;

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
  @override
  Widget build(BuildContext context) {

    final cartProvider = Provider.of<CartProvider>(context);
    var total = cartProvider.getTotalPrice().toStringAsFixed(2);


    var cartBox = Hive.box('cart_model');

    myDB = getEmployees();


    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: backButton(context),
        backgroundColor: Colors.white,
        title: GestureDetector(
          onTap: (){
            print("${total.toString().trim()}");
          },
          child: Text(
            "Cart Items",
            style: TextStyle(fontSize: 16.sp, color: Colors.black),
          ),
        ),
      ),

      body:
      SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding:  EdgeInsets.only(left: 15, right: 15, top: 30),
                child: Column(
                  children: [
                    Container(

                      height: MediaQuery.of(context).size.height*0.75,
                      color: Colors.white,

                      child: ListView.builder(
                          itemCount: listEmployees.length,
                          itemBuilder: (context, index) {
                            Cart cart = listEmployees[index];

                            return Card(
                              child: Container(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Container(
                                      height: 20.h,
                                      width: 85.w,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(0.0, 1.0), //(x,y)
                                            blurRadius: 3.0,
                                          ),
                                        ],
                                        color: Color(0xffE1DADC),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 20.h,
                                            width: 100.w,
                                            // width: 85.w,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(15),
                                                child: Image.network(
                                                  "${cart.image}",
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              // margin: EdgeInsets.only(right: 2.w, bottom: 2.w),
                                              height: 4.h,
                                              width: 8.w,
                                              decoration: BoxDecoration(
                                                color: kSignupColor,
                                                 borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {

                                                    // myDB.deleteItem(listEmployees[index]).whenComplete(() {
                                                    //   setState(() {
                                                    //     listEmployees.removeAt(index);
                                                    //   });
                                                    // });
                                                    cartBox.deleteAt(index);
                                                    cartProvider.removeTotalPrice(
                                                        double.parse(cart.productPrice!));
                                                    // var snackBar = SnackBar(content:
                                                    // Text('Item has been Removed from Cart Successfuly'),
                                                    //   backgroundColor: Colors.red.shade700,
                                                    // duration: Duration(milliseconds: 100),);
                                                    // ScaffoldMessenger.of(context).showSnackBar(snackBar);


                                                  });
                                                },
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                  size: 15.sp,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 80.w,
                                      child: Text(
                                        cart.productName.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w400,
                                            height: 2),
                                      ),
                                    ),
                                    Container(
                                      width: 80.w,
                                      child: Text(
                                        cart.productPrice.toString(),
                                        style: TextStyle(
                                            color: kSigninColor,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                      ),
                    ),
                    Card(
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.08,
                        color: Colors.grey.shade300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Total Amount",style: textStyle(),),
                            Text("\$$total",style: textStyle()),
                            ElevatedButton(onPressed: (){

                              Navigator.push(context, MaterialPageRoute(builder: (context)
                              =>CheckOutScreen(
                                total:total
                              )));


                            }, child: Text("CheckOut")),
                            // Text("\$555",style: textStyle()),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle textStyle(){
    return TextStyle(
        color: Colors.black,
        fontSize: 17.sp,
        fontWeight: FontWeight.bold,
        height: 1.5);
  }
}