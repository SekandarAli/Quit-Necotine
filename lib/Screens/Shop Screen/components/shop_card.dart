// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nicotine/Screens/Shop%20Screen/database/datbase_helper.dart';
import 'package:nicotine/Screens/Shop%20Screen/models/cart_model.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sizer/sizer.dart';

import '../../../Constant.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';

class ShopCard extends StatefulWidget {

  final snap;

  ShopCard({required this.snap, Key? key}) : super(key: key);

  @override
  State<ShopCard> createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  int quantity = 0;

  void addCart(Cart cart) {
    final cartBox = Hive.box('cart_model');
    cartBox.add(cart);
  }

  @override
  Widget build(BuildContext context) {
    Cart? cartData;
    int newquantity;


    final cart = Provider.of<CartProvider>(context);
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          Container(
            height: 25.h,
            width: 85.w,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0),
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
                        "${widget.snap["productImage"].toString()}",
                        fit: BoxFit.cover,
                      ),),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 2.w, bottom: 2.w),
                    height: 6.h,
                    width: 12.w,
                    decoration: BoxDecoration(
                      color: kSignupColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {

                        if (quantity == 0) {
                          print(".............insert function start............");
                          newquantity = quantity + 1;

                          cartData = Cart(
                            id: widget.snap.toString(),
                            productName: widget.snap["title"].toString(),
                            initialPrice: double.parse(widget.snap["price"]),
                            productPrice: widget.snap["price"].toString(),
                            quantity: newquantity,
                            image: widget.snap["productImage"].toString(),

                          );
                          addCart(cartData!);
                          cart.addCounter();
                          print("aaaaa${cart.counter}");

                          setState(() {
                            quantity = cartData!.quantity!;
                          });

                          print("quantityyyyyy$quantity");

                          ///ADD TOTAL AMOUNT
                          cart.addTotalPrice(double.parse(widget.snap["price"]));

                          print(".............insert function end............");

                          var snackBar = SnackBar(content:
                          Text('Item has been Added to Cart Successfuly'),
                            backgroundColor: Colors.green.shade700,
                           duration: Duration(milliseconds: 100),);

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Icon(
                        Icons.shopping_cart_rounded,
                        color: Colors.white,
                        size: 22.sp,
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
              widget.snap["title"].toString(),

              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  height: 2),
            ),
          ),
          Container(
            width: 80.w,
            child: Text(
              "£ ${widget.snap["price"].toString()}",
              // "£120.00",
              style: TextStyle(
                  color: kSigninColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
