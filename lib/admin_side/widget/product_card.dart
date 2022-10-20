import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../Constant.dart';
import '../add_products/edit_product.dart';


class ProductCard extends StatelessWidget {
  final snap;
  var id;
  var delete;

  ProductCard({required this.snap, required this.id, required this.delete,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     // final String docId ="${snap["docId"].toString()}";
    print("new id $id");
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
                  // height: 20.h,
                  // width: 100.w,
                  width: 85.w,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                          margin: EdgeInsets.only(left: 2.w, bottom: 2.w),
                          height: 5.h,
                          width: 10.w,
                          decoration: BoxDecoration(
                            color: kSignupColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              size: 20.sp,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProduct(
                                        newID: id,
                                        price:"${snap["price"].toString()}", description:"${snap["description"].toString()}", title: "${snap["title"].toString()}", imgUrl: "${snap["productImage"].toString()}")),
                              );
                            },
                          )),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: EdgeInsets.only(right: 2.w, bottom: 2.w),
                        height: 5.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                          color: kSignupColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            size: 20.sp,
                            color: Colors.white,
                          ),
                          onPressed: () {

                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      title: Text('Delete Product'),
                                      content: Text(
                                          "are you sure you want to delete this product!"),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text("Ok"),
                                          onPressed: ()async{
                                            delete.delete();
                                            Navigator.pop(context);

                                            print("check");
                                          },
                                        ),
                                        TextButton(
                                          child: Text("Cancel"),
                                          onPressed: () {
                                            // callback function for on click event of Cancel button
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ]);
                                });
                          },
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            width: 80.w,
            child: Text(
              "${snap["title"].toString()}"
              // "120-day Quit Nicotine 4 Life Programme"
              ,
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
              "£${snap["price"].toString()}",
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
