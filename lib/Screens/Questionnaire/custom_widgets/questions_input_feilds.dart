import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../Constant.dart';

class QuestionsInputFeild extends StatelessWidget {
  final String textLabel;
  final TextEditingController textEditingController;
  final String reqOpt;
  final String errorMessage;

  const QuestionsInputFeild(
      {Key? key,
      required this.textEditingController,
      required this.textLabel,
      required this.errorMessage,

      required this.reqOpt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 3.h,
            width: 90.w,
            child: RichText(
              text: TextSpan(
                text: textLabel,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 12.sp),
                children: <TextSpan>[
                  TextSpan(
                      text: reqOpt,
                      style: TextStyle(
                          color: kSignupColor,
                          fontWeight: FontWeight.w300,
                          fontSize: 12.sp)),
                ],
              ),
            ),
          ),
          Container(
            width: 90.w,
            // margin: EdgeInsets.only(top: 5.sp),
            // color: Colors.pink,
            child: TextFormField(
              enabled: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return errorMessage;
                }
                return null;
              },
              controller: textEditingController,
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black,
                    )),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 0.3.sp,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
