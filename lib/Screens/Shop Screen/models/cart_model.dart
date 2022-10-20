import 'package:hive/hive.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 1)
class Cart extends HiveObject{
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? productPrice;
  @HiveField(2)
  String? productName;
  @HiveField(3)
  String? image;
  @HiveField(4)
  double? initialPrice;
  @HiveField(5)
  int? quantity;

  Cart({
    this.id,
    this.productPrice,
    this.productName,
    this.image,
    this.initialPrice,
    this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productPrice': productPrice,
      'productName': productName,
      'image': image,
      'initialPrice': initialPrice,
      'quantity': quantity,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] as String,
      productPrice: map['productPrice'] as String,
      productName: map['productName'] as String,
      image: map['image'] as String,
      initialPrice: map['initialPrice'] as double,
      quantity: map['quantity'] as int,
    );
  }
}

