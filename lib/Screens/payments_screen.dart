import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import 'Components/backButton.dart';
import 'Home Screens/dash_bord.dart';
import 'welldone_screen.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({Key? key}) : super(key: key);

  @override
  _PaymentsScreenState createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  TextEditingController c11 = TextEditingController();
  TextEditingController cvv = TextEditingController();
  TextEditingController expiry = TextEditingController();
  TextEditingController country = TextEditingController();
  String methodSelector = "Card";
  final _formKey = GlobalKey<FormState>();

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
            builder: (context) => WellDoneScreen(),
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
        backgroundColor: Colors.white,
        title: Text(
          "Payments",
          style: TextStyle(fontSize: 16.sp, color: Colors.black),
        ),
        actions: [
          // Icon(
          //   Icons.more_horiz,
          //   size: 24.sp,
          // ),
          // SizedBox(
          //   width: 5.sp,
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => DashBord()));
              },
              child: Text(
                "Skip",
                style: TextStyle(fontSize: 12.sp, color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            width: 8.sp,
          ),
        ],
      ),
      body: Container(
        height: 100.h,
        width: 100.w,
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          // child: Column(
          //   children: [
          //     ShopCard(
          //   //    shopItem: shopList[0],
          //     ),
          //     SizedBox(
          //       height: 3.h,
          //     ),
          //     Text(
          //       "Payment for\n1. 120-day Quit Nicotine 4 Life Programme\n2. To include inner health scan\n3. Tissue cells salts\n4. Guide book",
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //           color: Colors.black,
          //           height: 1.5,
          //           fontSize: 12.sp,
          //           fontWeight: FontWeight.w300),
          //     ),
          //     SizedBox(
          //       height: 3.h,
          //     ),
          //     Text(
          //       "£220.00",
          //       style: TextStyle(
          //           color: kSigninColor,
          //           fontWeight: FontWeight.bold,
          //           fontSize: 30.sp),
          //     ),
          //
          //     // SizedBox(
          //     //   height: 3.h,
          //     // ),
          //     // Form(
          //     //   key: _formKey,
          //     //   child: Column(
          //     //     children: [
          //     //       Container(
          //     //         margin: EdgeInsets.symmetric(horizontal: 5.w),
          //     //         child: Row(
          //     //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     //           children: [
          //     //             InkWell(
          //     //               onTap: () {
          //     //                 setState(() {
          //     //                   methodSelector = "Card";
          //     //                 });
          //     //               },
          //     //               child: Container(
          //     //                 height: 8.h,
          //     //                 width: 28.w,
          //     //                 decoration: BoxDecoration(
          //     //                   color: methodSelector == "Card"
          //     //                       ? kSigninColor
          //     //                       : Colors.white,
          //     //                   // Color(0xff505050),
          //     //                   borderRadius: BorderRadius.circular(15),
          //     //                   border: Border.all(
          //     //                       color: kSigninColor, width: 0.8.sp),
          //     //                 ),
          //     //                 child: ListTile(
          //     //                   contentPadding:
          //     //                       EdgeInsets.only(right: 50.sp, left: 5.sp),
          //     //                   title: Icon(
          //     //                     Icons.payment,
          //     //                     color: methodSelector == "Card"
          //     //                         ? Colors.white
          //     //                         : Colors.black,
          //     //                   ),
          //     //                   subtitle: Text(
          //     //                     "Card",
          //     //                     style: TextStyle(
          //     //                         color: methodSelector == "Card"
          //     //                             ? Colors.white
          //     //                             : Colors.black,
          //     //                         fontSize: 11.sp),
          //     //                   ),
          //     //                 ),
          //     //               ),
          //     //             ),
          //     //             InkWell(
          //     //               onTap: () {
          //     //                 setState(() {
          //     //                   methodSelector = "Paypal";
          //     //                 });
          //     //               },
          //     //               child: Container(
          //     //                 height: 8.h,
          //     //                 width: 28.w,
          //     //                 decoration: BoxDecoration(
          //     //                   color: methodSelector == "Paypal"
          //     //                       ? kSigninColor
          //     //                       : Colors.white,
          //     //                   // Color(0xff505050),
          //     //                   borderRadius: BorderRadius.circular(15),
          //     //                   border: Border.all(
          //     //                       color: kSigninColor, width: 0.8.sp),
          //     //                 ),
          //     //                 child: ListTile(
          //     //                   // contentPadding: EdgeInsets.only(right: 40.sp, left: 5.sp),
          //     //                   title: Container(
          //     //                       margin:
          //     //                           EdgeInsets.only(left: 0.w, right: 13.w),
          //     //                       height: 2.h,
          //     //                       width: 2.w,
          //     //                       child: methodSelector == "Paypal"
          //     //                           ? Image.asset(
          //     //                               "assets/paypale.png",
          //     //                               fit: BoxFit.fill,
          //     //                             )
          //     //                           : Image.network(
          //     //                               "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXb0PvXc7nwto6yrSgihDdTjlMCCdrOXlB0A&usqp=CAU",
          //     //                               // "assets/paypale.png",
          //     //                               fit: BoxFit.fill,
          //     //                             )),
          //     //                   subtitle: Text(
          //     //                     "Paypal",
          //     //                     style: TextStyle(
          //     //                         color: methodSelector == "Paypal"
          //     //                             ? Colors.white
          //     //                             : Colors.black,
          //     //                         fontSize: 11.sp),
          //     //                   ),
          //     //                 ),
          //     //               ),
          //     //             ),
          //     //             Container(
          //     //                 height: 8.h,
          //     //                 width: 25.w,
          //     //                 decoration: BoxDecoration(
          //     //                   color: Colors.white,
          //     //                   borderRadius: BorderRadius.circular(15),
          //     //                   border: Border.all(
          //     //                       color: kSigninColor, width: 0.8.sp),
          //     //                 ),
          //     //                 child: Icon(
          //     //                   Icons.more_horiz,
          //     //                   color: Colors.black,
          //     //                   size: 25.sp,
          //     //                 )),
          //     //           ],
          //     //         ),
          //     //       ),
          //     //       SizedBox(height: 1.h),
          //     //       Container(
          //     //         child: Column(
          //     //           children: [
          //     //             Container(
          //     //               height: 3.5.h,
          //     //               width: 90.w,
          //     //               // color: Colors.purple,
          //     //               child: Text(
          //     //                 "Card number",
          //     //                 style: TextStyle(
          //     //                     color: Colors.black,
          //     //                     fontWeight: FontWeight.w300,
          //     //                     fontSize: 12.sp),
          //     //               ),
          //     //             ),
          //     //             Container(
          //     //               height: 6.5.h,
          //     //               width: 90.w,
          //     //               // margin: EdgeInsets.only(top: 5.sp),
          //     //               // color: Colors.pink,
          //     //               child: TextFormField(
          //     //                 controller: c11,
          //     //                 cursorColor: Colors.black,
          //     //                 style: TextStyle(color: Colors.black),
          //     //                 textInputAction: TextInputAction.next,
          //     //                 keyboardType: TextInputType.text,
          //     //                 // validator: ,
          //     //                 decoration: InputDecoration(
          //     //                   fillColor: Colors.white,
          //     //                   // Color(0xff505050),
          //     //                   filled: true,
          //     //                   hintText: "1234 1234 1234 1234",
          //     //                   hintStyle: TextStyle(
          //     //                       color: Colors.black,
          //     //                       fontSize: 12.sp,
          //     //                       fontWeight: FontWeight.w300),
          //     //                   // contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
          //     //                   focusedBorder: OutlineInputBorder(
          //     //                       borderRadius: BorderRadius.circular(10),
          //     //                       borderSide: BorderSide(
          //     //                         width: 0.8.sp,
          //     //                         color: kSigninColor,
          //     //                       )),
          //     //                   enabledBorder: OutlineInputBorder(
          //     //                     borderRadius: BorderRadius.circular(10),
          //     //                     borderSide: BorderSide(
          //     //                       color: kSigninColor,
          //     //                       width: 0.8.sp,
          //     //                     ),
          //     //                   ),
          //     //                 ),
          //     //               ),
          //     //             ),
          //     //           ],
          //     //         ),
          //     //       ),
          //     //       SizedBox(
          //     //         height: 1.h,
          //     //       ),
          //     //       Container(
          //     //         width: 90.w,
          //     //         child: Row(
          //     //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     //           children: [
          //     //             Container(
          //     //               child: Column(
          //     //                 children: [
          //     //                   Container(
          //     //                     height: 3.5.h,
          //     //                     width: 40.w,
          //     //                     // color: Colors.purple,
          //     //                     child: Text(
          //     //                       "Expiry",
          //     //                       style: TextStyle(
          //     //                           color: Colors.black,
          //     //                           fontWeight: FontWeight.w300,
          //     //                           fontSize: 12.sp),
          //     //                     ),
          //     //                   ),
          //     //                   Container(
          //     //                     height: 6.5.h,
          //     //                     width: 40.w,
          //     //                     // margin: EdgeInsets.only(top: 5.sp),
          //     //                     // color: Colors.pink,
          //     //                     child: TextFormField(
          //     //                       controller: expiry,
          //     //                       cursorColor: Colors.black,
          //     //                       style: TextStyle(color: Colors.black),
          //     //                       textInputAction: TextInputAction.next,
          //     //                       keyboardType: TextInputType.datetime,
          //     //                       // validator: ,
          //     //                       decoration: InputDecoration(
          //     //                         fillColor: Colors.white,
          //     //                         // Color(0xff505050),
          //     //                         filled: true,
          //     //                         hintText: "MM/YY",
          //     //                         hintStyle: TextStyle(
          //     //                             color: Colors.black,
          //     //                             fontSize: 12.sp,
          //     //                             fontWeight: FontWeight.w300),
          //     //                         // contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
          //     //                         focusedBorder: OutlineInputBorder(
          //     //                             borderRadius:
          //     //                                 BorderRadius.circular(10),
          //     //                             borderSide: BorderSide(
          //     //                               width: 0.8.sp,
          //     //                               color: kSigninColor,
          //     //                             )),
          //     //                         enabledBorder: OutlineInputBorder(
          //     //                           borderRadius: BorderRadius.circular(10),
          //     //                           borderSide: BorderSide(
          //     //                             color: kSigninColor,
          //     //                             width: 0.8.sp,
          //     //                           ),
          //     //                         ),
          //     //                       ),
          //     //                     ),
          //     //                   ),
          //     //                 ],
          //     //               ),
          //     //             ),
          //     //             Container(
          //     //               child: Column(
          //     //                 children: [
          //     //                   Container(
          //     //                     height: 3.5.h,
          //     //                     width: 40.w,
          //     //                     // color: Colors.purple,
          //     //                     child: Text(
          //     //                       "CVV",
          //     //                       style: TextStyle(
          //     //                           color: Colors.black,
          //     //                           fontWeight: FontWeight.w300,
          //     //                           fontSize: 12.sp),
          //     //                     ),
          //     //                   ),
          //     //                   Container(
          //     //                     height: 6.5.h,
          //     //                     width: 40.w,
          //     //                     // margin: EdgeInsets.only(top: 5.sp),
          //     //                     // color: Colors.pink,
          //     //                     child: TextFormField(
          //     //                       controller: cvv,
          //     //                       cursorColor: Colors.black,
          //     //                       style: TextStyle(color: Colors.black),
          //     //                       textInputAction: TextInputAction.next,
          //     //                       keyboardType: TextInputType.number,
          //     //                       // validator: ,
          //     //                       decoration: InputDecoration(
          //     //                         fillColor: Colors.white,
          //     //                         // Color(0xff505050),
          //     //                         filled: true,
          //     //                         hintText: "CVV",
          //     //                         hintStyle: TextStyle(
          //     //                             color: Colors.black,
          //     //                             fontSize: 12.sp,
          //     //                             fontWeight: FontWeight.w300),
          //     //                         // contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
          //     //                         focusedBorder: OutlineInputBorder(
          //     //                             borderRadius:
          //     //                                 BorderRadius.circular(10),
          //     //                             borderSide: BorderSide(
          //     //                               width: 0.8.sp,
          //     //                               color: kSigninColor,
          //     //                             )),
          //     //                         enabledBorder: OutlineInputBorder(
          //     //                           borderRadius: BorderRadius.circular(10),
          //     //                           borderSide: BorderSide(
          //     //                             color: kSigninColor,
          //     //                             width: 0.8.sp,
          //     //                           ),
          //     //                         ),
          //     //                       ),
          //     //                     ),
          //     //                   ),
          //     //                 ],
          //     //               ),
          //     //             ),
          //     //           ],
          //     //         ),
          //     //       ),
          //     //       SizedBox(
          //     //         height: 1.h,
          //     //       ),
          //     //       Container(
          //     //         child: Column(
          //     //           children: [
          //     //             Container(
          //     //               height: 3.5.h,
          //     //               width: 90.w,
          //     //               // color: Colors.purple,
          //     //               child: Text(
          //     //                 "Country",
          //     //                 style: TextStyle(
          //     //                     color: Colors.black,
          //     //                     fontWeight: FontWeight.w300,
          //     //                     fontSize: 12.sp),
          //     //               ),
          //     //             ),
          //     //             Stack(
          //     //               children: [
          //     //                 Container(
          //     //                   height: 6.5.h,
          //     //                   width: 90.w,
          //     //                   // margin: EdgeInsets.only(top: 5.sp),
          //     //                   // color: Colors.pink,
          //     //                   child: TextFormField(
          //     //                     enabled: false,
          //     //                     controller: country,
          //     //                     cursorColor: Colors.black,
          //     //                     style: TextStyle(color: Colors.black),
          //     //                     textInputAction: TextInputAction.next,
          //     //                     keyboardType: TextInputType.text,
          //     //                     // validator: ,
          //     //                     decoration: InputDecoration(
          //     //                         fillColor: Colors.white,
          //     //                         //  Color(0xff505050),
          //     //                         filled: true,
          //     //                         focusedBorder: OutlineInputBorder(
          //     //                             borderRadius:
          //     //                                 BorderRadius.circular(10),
          //     //                             borderSide: BorderSide(
          //     //                               width: 0.8.sp,
          //     //                               color: kSigninColor,
          //     //                             )),
          //     //                         enabledBorder: OutlineInputBorder(
          //     //                           borderRadius: BorderRadius.circular(10),
          //     //                           borderSide: BorderSide(
          //     //                             color: kSigninColor,
          //     //                             width: 0.8.sp,
          //     //                           ),
          //     //                         ),
          //     //                         disabledBorder: OutlineInputBorder(
          //     //                           borderRadius: BorderRadius.circular(10),
          //     //                           borderSide: BorderSide(
          //     //                             color: kSigninColor,
          //     //                             width: 0.8.sp,
          //     //                           ),
          //     //                         ),
          //     //                         suffixIcon: Icon(
          //     //                           Icons.keyboard_arrow_down_rounded,
          //     //                           size: 20.sp,
          //     //                           color: kSigninColor,
          //     //                         )),
          //     //                   ),
          //     //                 ),
          //     //                 Container(
          //     //                   height: 6.5.h,
          //     //                   width: 90.w,
          //     //                   child: DropdownButton<String>(
          //     //                     underline: Container(),
          //     //                     icon: Container(),
          //     //                     items: countries.map((String value) {
          //     //                       return DropdownMenuItem<String>(
          //     //                         value: value,
          //     //                         child: Text(value),
          //     //                       );
          //     //                     }).toList(),
          //     //                     onChanged: (value) {
          //     //                       setState(() {
          //     //                         country.text = value!;
          //     //                       });
          //     //                     },
          //     //                   ),
          //     //                 ),
          //     //               ],
          //     //             ),
          //     //           ],
          //     //         ),
          //     //       ),
          //     //     ],
          //     //   ),
          //     // ),
          //     SizedBox(
          //       height: 3.h,
          //     ),
          //     Container(
          //       height: 7.h,
          //       width: 65.w,
          //       decoration:
          //           BoxDecoration(borderRadius: BorderRadius.circular(15)),
          //       child: RaisedButton(
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(15)),
          //         color: kSignupColor,
          //         onPressed: () async {
          //           await makePayment("220").then((value) {});
          //         },
          //         child: Text(
          //           "Pay Now",
          //           style: TextStyle(
          //               color: Colors.white,
          //               fontWeight: FontWeight.w600,
          //               fontSize: 16.sp),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
