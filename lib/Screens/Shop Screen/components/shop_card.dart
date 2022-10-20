import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nicotine/Screens/Shop%20Screen/database/datbase_helper.dart';
import 'package:nicotine/Screens/Shop%20Screen/models/cart_model.dart';
import 'package:sizer/sizer.dart';

import '../../../Constant.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';

class ShopCard extends StatelessWidget {
  final snap;

  ShopCard({required this.snap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DBHelper? dbHelper = DBHelper();
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
                        "${snap["productImage"].toString()}",
                        fit: BoxFit.cover,
                      )),
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
                        print("object");
                        dbHelper!
                            .insert(Cart(
                                id: snap,
                                productName: snap["title"],
                                initialPrice: snap["price"],
                                productPrice: snap["price"],
                                quantity: 1,
                                image: snap["productImage"].toString()))
                            .then((value) {
                          cart.addTotalPrice(
                              double.parse(["price"].toString()));
                          cart.addCounter();

                          final snackBar = SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Product is added to cart'),
                            duration: Duration(seconds: 1),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }).onError((error, stackTrace) {
                          print("error" + error.toString());
                          final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Product is already added in cart'),
                              duration: Duration(seconds: 1));

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
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
              snap["title"].toString(),
              // "120-day Quit Nicotine 4 Life Programme"

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
              "£ ${snap["price"].toString()}",
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
