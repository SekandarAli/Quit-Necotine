class Cart {
  late final int? id;

  final productName;
  final int? productPrice;
  final int? quantity;
  final String? image;
  final String? initialPrice;

  Cart({
    required this.id,
    required this.productPrice,
    required this.productName,
    required this.quantity,
    required this.image,
    required this.initialPrice,
  });

  Cart.fromMap(Map<dynamic, dynamic> res)
      : id = res["id"],
        productPrice = res["productPrice"],
        productName = res["productName"],
        quantity = res["quantity"],
        image = res["image"],
        initialPrice = res["initialPrice"];

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "productPrice": productPrice,
      "productName": productName,
      "quantity": quantity,
      "image": image,
      "initialPrice": initialPrice,
    };
  }
}
