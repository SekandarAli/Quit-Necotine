import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/datbase_helper.dart';
import '../models/cart_model.dart';

class CartProvider with ChangeNotifier {
  DBHelper db = DBHelper();

  // For counter badge::
  int _counter = 0;

  int get counter => _counter;

  // For calucataing total price of the cart::
  double _totalPrice = 0.0;

  double get total => _totalPrice;

  late Future<List<Cart>> _cart;

  Future<List<Cart>> get cart => _cart;

//For getting cart list frm the cart::
  Future<List<Cart>> getData() async {
    _cart = db.getCartList();
    return _cart;
  }

  //Why we use shared prefences here because  for saving data inside the cart while we shutdown the application if items are added in the cart::

  /// set value ::
  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', counter);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

//// get value ::
  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    _totalPrice = prefs.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

////For COUNTER::::
// ADD COUNETER::

  void addCounter() {
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  // Remove COUNETER::

  void removeCounter() {
    _counter--;
    _setPrefItems();
    notifyListeners();
  }

  // Get COUNETER::

  int getCounter() {
    _getPrefItems();
    return _counter;
  }

  ////For  Total::::
// ADD Totalprice in  cart::

  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    _setPrefItems();
    notifyListeners();
  }

  // Remove TotalPrice from the cart ::

  void removeTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    _setPrefItems();
    notifyListeners();
  }

  // Get TotalPrice ::

  double getTotalPrice() {
    _getPrefItems();
    return _totalPrice;
  }
}
