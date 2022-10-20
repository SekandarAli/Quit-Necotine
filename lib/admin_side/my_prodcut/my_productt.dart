import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nicotine/admin_side/widget/product_card.dart';
import 'package:sizer/sizer.dart';

class MyProductt extends StatelessWidget {
  const MyProductt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "My Products",
            style: TextStyle(fontSize: 16.sp, color: Colors.black),
          ),
        ),
        // body: Container(
        //   height: 100.h,
        //   width: 100.w,
        //   color: Colors.white,
        //   child: ListView.builder(
        //       itemCount: shopList.length,
        //       itemBuilder: (BuildContext context, int index) {
        //         return GestureDetector(
        //           onTap: () {
        //             // Navigator.push(
        //             //   context,
        //             //   MaterialPageRoute(
        //             //       builder: (context) => ShopPayment(
        //             //         shopItem: shopList[index],
        //             //       )),
        //             // );
        //           },
        //           // child: ProductCard(
        //           //   shopItem: shopList[index],
        //           // ),
        //         );
        //       }),
        // ),
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
              itemBuilder: (context, index) => ProductCard(
                id: snaphot.data?.docs[index].id,
                snap: snaphot.data?.docs[index].data(),
                delete: snaphot.data?.docs[index].reference,
              ),
            );
          },
        ));
  }
}
