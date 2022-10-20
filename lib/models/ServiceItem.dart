import 'package:flutter/material.dart';

class ServiceItem {
  late String image;
  late String url;
  late String itemName;
  late Color color;
  ServiceItem(
      {required this.image,
      required this.url,
      required this.itemName,
      required this.color});
}
