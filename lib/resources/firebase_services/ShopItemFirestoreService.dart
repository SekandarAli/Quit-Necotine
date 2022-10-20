import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nicotine/models/ShopItem.dart';

class ShopItemFirestoreService {
  final collectionName = "ShopItems";
  Future<List<ShopItem>> getShopItems(
      // String userEmail,
      ) async {
    try {
      var map = await FirebaseFirestore.instance
          .collection(collectionName)
          // .doc(userEmail)
          .snapshots();
      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection(collectionName);

      QuerySnapshot querySnapshot = await _collectionRef.get();

      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();

      print(allData);

      List<ShopItem> shopItems = [];
      allData.forEach((item) {
        final shop = item as Map<String, dynamic>;

        shopItems.add(ShopItem.fromJson(shop));
      });
      print("Shop Items: ${shopItems.length}");
      return shopItems;
    } catch (e) {
      throw e.toString();
    }
  }
}
