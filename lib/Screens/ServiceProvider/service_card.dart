import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

import '../../../Constant.dart';
import '../../../models/ShopItem.dart';
import '../../models/ServiceItem.dart';
import '../../resources/UrlLauncherHelper.dart';

class ServiceCard extends StatelessWidget {
  final ServiceItem serviceItem;

  final bool isAsset;
  ServiceCard({required this.serviceItem, required this.isAsset, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchURL(serviceItem.url);
      },
      child: Container(
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
                    height: 25.h,
                    // height: 20.h,
                    // width: 100.w,
                    width: 85.w,
                    decoration: BoxDecoration(
                      color: serviceItem.color,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: serviceItem.image.isNotEmpty
                              ? Image.asset(
                                  serviceItem.image,
                                  // "assets/Mask/.png",
                                  fit: BoxFit.contain,
                                )
                              : Container()),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 80.w,
              child: Text(
                serviceItem.itemName,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    height: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
