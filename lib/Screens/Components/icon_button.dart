import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '../../Constant.dart';

class CustomButton extends StatelessWidget {
  final String btnText;
  final String icnString;
  final Function() ptr;
    final  Color clr;

  const CustomButton(
      {Key? key,
      required this.btnText,
        required this.clr,
      required this.icnString,
      required this.ptr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ptr,
      child: Container(
        height: 7.h,
        width: 90.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: clr, width: 1.sp)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //   CustomIcon(icnString: googleIcon),
            Container(
              height: 5.h,
              width: 8.w,
              child: SvgPicture.asset(
                icnString,
                width: 7,
                height: 7,
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              btnText,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }
}
