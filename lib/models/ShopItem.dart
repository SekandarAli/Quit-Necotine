class ShopItem {
  late String itemId;
  late String itemName;
  late double amount;
  late String description;
  late String image;

  ShopItem({
    required this.itemId,
    required this.itemName,
    required this.amount,
    required this.description,
    required this.image,
  });

  ShopItem.fromJson(Map<String, dynamic> json) {
    this.itemId = json['itemId'] ?? '';
    this.itemName = json['itemName'] ?? '';
    this.amount = json['amount'] == null ? (json['amount']).toDouble() : 0;
    this.description = json['description'] ?? '';
    this.image = json['image'] ?? '';
  }
}
