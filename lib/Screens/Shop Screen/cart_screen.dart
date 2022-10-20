import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:nicotine/Screens/Shop%20Screen/provider/cart_provider.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../Components/backButton.dart';
import 'database/datbase_helper.dart';
import 'models/cart_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper db = DBHelper();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: backButton(context),
        backgroundColor: Colors.white,
        title: Text(
          "Cart Items",
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
      body: Column(
        children: [
          FutureBuilder(
              future: cart.getData(),
              builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                if (snapshot.data!.isEmpty) {
                  Text("Cart is Empty");
                } else if (snapshot.hasData) {
                  return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            print(snapshot.data.toString());
                            return Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Image(
                                        image: NetworkImage(snapshot
                                            .data![index].image
                                            .toString()),
                                        height: 100,
                                        width: 100,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      // Expanded(
                                      //   child: Column(
                                      //     mainAxisAlignment:
                                      //     MainAxisAlignment.start,
                                      //     crossAxisAlignment:
                                      //     CrossAxisAlignment.start,
                                      //     children: [
                                      //       Row(
                                      //         mainAxisAlignment:
                                      //         MainAxisAlignment
                                      //             .spaceBetween,
                                      //         children: [
                                      //           Text(
                                      //             snapshot
                                      //                 .data![index].productName
                                      //                 .toString(),
                                      //             style: TextStyle(
                                      //                 fontWeight:
                                      //                 FontWeight.w500),
                                      //           ),
                                      //           InkWell(
                                      //               onTap: () {
                                      //                 db.delete(snapshot
                                      //                     .data![index].id!);
                                      //               },
                                      //               child: Icon(Icons.delete)),
                                      //         ],
                                      //       ),
                                      //       SizedBox(
                                      //         height: 5.00,
                                      //       ),
                                      //       Text(
                                      //         snapshot.data![index].unitTag
                                      //             .toString() +
                                      //             "  " +
                                      //             r" $" +
                                      //             snapshot
                                      //                 .data![index].productPrice
                                      //                 .toString(),
                                      //         style: TextStyle(
                                      //             fontWeight: FontWeight.w500),
                                      //       ),
                                      //       Align(
                                      //         child: Container(
                                      //           height: 35,
                                      //           width: 100,
                                      //           decoration: BoxDecoration(
                                      //               color: Colors.green,
                                      //               borderRadius:
                                      //               BorderRadius.circular(
                                      //                   5.00)),
                                      //           child: Padding(
                                      //             padding:
                                      //             const EdgeInsets.all(4.0),
                                      //             child: Row(
                                      //               mainAxisAlignment:
                                      //               MainAxisAlignment
                                      //                   .spaceBetween,
                                      //               children: [
                                      //                 InkWell(
                                      //                     onTap: () {
                                      //                       int quantity =
                                      //                       snapshot
                                      //                           .data![
                                      //                       index]
                                      //                           .quantity!;
                                      //
                                      //                       int price = snapshot
                                      //                           .data![index]
                                      //                           .initialPrice!;
                                      //
                                      //                       quantity--;
                                      //                       int? newPrice =
                                      //                           price *
                                      //                               quantity;
                                      //                       if (quantity > 0) {
                                      //                         db
                                      //                             .updateQuantity(Cart(
                                      //                             id: snapshot
                                      //                                 .data![
                                      //                             index]
                                      //                                 .id!,
                                      //                             productId: snapshot
                                      //                                 .data![
                                      //                             index]
                                      //                                 .productId
                                      //                                 .toString(),
                                      //                             productName: snapshot
                                      //                                 .data![
                                      //                             index]
                                      //                                 .productName!,
                                      //                             initialPrice: snapshot
                                      //                                 .data![
                                      //                             index]
                                      //                                 .initialPrice,
                                      //                             productPrice:
                                      //                             newPrice,
                                      //                             quantity:
                                      //                             quantity,
                                      //                             unitTag: snapshot
                                      //                                 .data![
                                      //                             index]
                                      //                                 .unitTag
                                      //                                 .toString(),
                                      //                             image: snapshot
                                      //                                 .data![
                                      //                             index]
                                      //                                 .image!
                                      //                                 .toString()))
                                      //                             .then(
                                      //                                 (value) {
                                      //                               newPrice = 0;
                                      //                               quantity = 0;
                                      //                               cart.removeTotalPrice(
                                      //                                   double.parse(snapshot
                                      //                                       .data![
                                      //                                   index]
                                      //                                       .initialPrice
                                      //                                       .toString()));
                                      //                             }).onError((error,
                                      //                             stackTrace) {
                                      //                           print(error
                                      //                               .toString());
                                      //                         });
                                      //                       }
                                      //                     },
                                      //                     child: Icon(
                                      //                       Icons.remove,
                                      //                       color: Colors.white,
                                      //                     )),
                                      //                 Text(
                                      //                   snapshot.data![index]
                                      //                       .quantity
                                      //                       .toString(),
                                      //                   style: TextStyle(
                                      //                       color:
                                      //                       Colors.white),
                                      //                 ),
                                      //                 InkWell(
                                      //                     onTap: () {
                                      //                       int quantity =
                                      //                       snapshot
                                      //                           .data![
                                      //                       index]
                                      //                           .quantity!;
                                      //
                                      //                       int price = snapshot
                                      //                           .data![index]
                                      //                           .initialPrice!;
                                      //
                                      //                       quantity++;
                                      //                       int? newPrice =
                                      //                           price *
                                      //                               quantity;
                                      //                       db
                                      //                           .updateQuantity(Cart(
                                      //                           id: snapshot
                                      //                               .data![
                                      //                           index]
                                      //                               .id!,
                                      //                           productId: snapshot
                                      //                               .data![
                                      //                           index]
                                      //                               .productId
                                      //                               .toString(),
                                      //                           productName: snapshot
                                      //                               .data![
                                      //                           index]
                                      //                               .productName!,
                                      //                           initialPrice: snapshot
                                      //                               .data![
                                      //                           index]
                                      //                               .initialPrice,
                                      //                           productPrice:
                                      //                           newPrice,
                                      //                           quantity:
                                      //                           quantity,
                                      //                           unitTag: snapshot
                                      //                               .data![
                                      //                           index]
                                      //                               .unitTag
                                      //                               .toString(),
                                      //                           image: snapshot
                                      //                               .data![
                                      //                           index]
                                      //                               .image!
                                      //                               .toString()))
                                      //                           .then((value) {
                                      //                         newPrice = 0;
                                      //                         quantity = 0;
                                      //                         cart.addTotalPrice(
                                      //                             double.parse(snapshot
                                      //                                 .data![
                                      //                             index]
                                      //                                 .initialPrice
                                      //                                 .toString()));
                                      //                       }).onError((error,
                                      //                           stackTrace) {
                                      //                         print(error
                                      //                             .toString());
                                      //                       });
                                      //                     },
                                      //                     child: Icon(
                                      //                       Icons.add,
                                      //                       color: Colors.white,
                                      //                     )),
                                      //               ],
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //       SizedBox(
                                      //         height: 5,
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }));
                } else {}
                return Center(child: Text("data"));
              }),
          Consumer<CartProvider>(builder: (context, value, child) {
            return Visibility(
              visible: value.getTotalPrice().toStringAsFixed(2) == "0.00"
                  ? false
                  : true,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Reusable(
                        value: r'$' + value.getTotalPrice().toString(),
                        title: "Sub Total"),
                    Reusable(
                        value: r'$' + value.getTotalPrice().toString(),
                        title: "Discount 5%"),
                    Reusable(
                        value: r'$' + value.getTotalPrice().toString(),
                        title: " Total"),
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}

class Reusable extends StatelessWidget {
  final String title, value;

  Reusable({required this.value, required this.title}) : super();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: (Theme.of(context).textTheme.subtitle2),
          ),
          Text(
            value.toString(),
            style: (Theme.of(context).textTheme.subtitle2),
          )
        ],
      ),
    );
  }
}
