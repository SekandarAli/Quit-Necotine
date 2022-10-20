import 'package:flutter/material.dart';
import 'package:nicotine/admin_side/add_products/add_product.dart';
import 'package:nicotine/admin_side/my_prodcut/my_productt.dart';
import 'package:nicotine/admin_side/order_page/order_screen.dart';


class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3,
        child: Scaffold(
          backgroundColor: Colors.blueGrey[50],
          appBar: AppBar(
            title:  const Text("Admin Dashboard"),
            backgroundColor: const Color(0xffD61E3C),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  text: ("Add Product"),
                ),
                Tab(  text: ("My Products"),

                ),
                Tab(  text: ("Order Detail"),)
              ],
            ),
          ),
          body:TabBarView(children: [
           AddProduct(),
            const MyProductt(),
            OrderScreen(),
          ]),
        )
    );
  }
}
