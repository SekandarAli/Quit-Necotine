import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:nicotine/Screens/Components/backButton.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../../Constant.dart';
import '../../models/ShopItem.dart';
import 'purchase_successful.dart';

class ShopPayment extends StatefulWidget {
  final ShopItem shopItem;
  ShopPayment({required this.shopItem, Key? key}) : super(key: key);

  @override
  _ShopPaymentState createState() => _ShopPaymentState();
}

class _ShopPaymentState extends State<ShopPayment> {
  Map<String, dynamic>? paymentIntentData;

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51K2bXeHcpFyN7czAlt0ZH1PrKZyKRySaZywTK3mMjGaZ3ppycA3QVhisH3CZjMuC1bZ95MTz14EdOQPG1Gexy0bJ00KzKTHHQf',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("paid successfully")));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PurchaseSuccessful(),
          ),
        );

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntentData = await createPaymentIntent(
          amount, 'GBP'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: true,
                  style: ThemeMode.dark,
                  merchantCountryCode: 'US',
                  merchantDisplayName: 'ANNIE'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: backButton(context),
        // Padding(
        //   padding: EdgeInsets.only(left: 5.sp),
        //   child: Container(
        //     margin: EdgeInsets.only(
        //         top: 1.4.h, bottom: 1.4.h, left: 2.w, right: 2.w),
        //     decoration: BoxDecoration(
        //       color: Colors.white.withOpacity(0.1),
        //       borderRadius: BorderRadius.circular(50),
        //     ),
        //     child: Builder(
        //       builder: (context) => IconButton(
        //         onPressed: () => Navigator.pop(context),
        //         icon: Icon(
        //           Icons.arrow_back_ios_rounded,
        //           size: 12.sp,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        backgroundColor: Colors.white,
        title: Text(
          "Payment",
          style: TextStyle(fontSize: 16.sp, color: Colors.black),
        ),
        actions: [
          Icon(
            Icons.more_horiz,
            size: 24.sp,
          ),
          SizedBox(
            width: 5.sp,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 7.h,
        width: 65.w,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        // child: RaisedButton(
        //   shape:
        //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        //   color: kSignupColor,
        //   onPressed: () async {
        //     await makePayment(widget.shopItem.amount.toInt().toString());
        //     // Navigator.push(
        //     //   context,
        //     //   MaterialPageRoute(
        //     //     builder: (context) => PurchaseSuccessful(),
        //     //   ),
        //     // );
        //   },
        //   child: Text(
        //     "Pay £ ${widget.shopItem.amount}",
        //     style: TextStyle(
        //         color: Colors.white,
        //         fontWeight: FontWeight.w600,
        //         fontSize: 16.sp),
        //   ),
        // ),
      ),
      body: Container(
        height: 100.h,
        width: 100.w,
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      height: 20.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            // height: 20.h,
                            // width: 100.w,
                            width: 80.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 3.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  widget.shopItem.image,
                                  fit: BoxFit.contain,
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 90.w,
                      child: Text(
                        widget.shopItem.itemName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            height: 2),
                      ),
                    ),
                    Container(
                      // width: 80.w,
                      child: Text(
                        "£ ${widget.shopItem.amount}",
                        style: TextStyle(
                            color: kSigninColor,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 90.w,
                child: Text(
                  widget.shopItem.description,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      height: 2),
                ),
              ),
              // PaymentForm(),
              SizedBox(
                height: 10.h,
              ),

              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
