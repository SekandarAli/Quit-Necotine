import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../Constant.dart';

class CustomIcon extends StatelessWidget {
  final String icnString;

  const CustomIcon({Key? key, required this.icnString}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5.h,
      width: 8.w,
      child: SvgPicture.asset(
        icnString,
        width: 7,
        height: 7,
      ),
    );
  }
}
