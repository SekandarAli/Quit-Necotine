import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nicotine/Screens/Components/backButton.dart';
import 'package:nicotine/Screens/Shop%20Screen/cart_screen.dart';
import 'package:sizer/sizer.dart';
import 'components/shop_card.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          leading: backButton(context),
          backgroundColor: Colors.white,
          title: Text(
            "Shop",
            style: TextStyle(fontSize: 16.sp, color: Colors.black),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ),
                );
              },
              child: Center(
                child: Badge(
                  child: Icon(
                    Icons.shopping_cart_rounded,
                    color: Colors.black,
                  ),
                  badgeContent: Text(
                    "0",
                    style: TextStyle(color: Colors.white),
                  ),
                  animationDuration: Duration(milliseconds: 300),
                ),
              ),
            ),
            SizedBox(
              width: 25.sp,
            ),
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("products").snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snaphot) {
            if (snaphot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            }

            return ListView.builder(
              itemCount: snaphot.data?.docs.length,
              itemBuilder: (context, index) => ShopCard(
                snap: snaphot.data?.docs[index].data(),
              ),
            );
          },
        ));
  }
}
