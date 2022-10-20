
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  double _totalPrice = 0.0;

  double get totalPrice => _totalPrice;

  double _subTotalPrice = 0.0;

  double get subTotalPrice => _subTotalPrice;



  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setInt('cart_item', _counter);
    // prefs.setDouble('total_price', _totalPrice);
    // prefs.setDouble('sub_total_price', _subTotalPrice);
    // prefs.setDouble('tax', _tax);
    // prefs.setDouble('cash_discount', _cashDiscount);
    // prefs.setDouble('tax_percentage', _taxPercentage);

    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // _counter = prefs.getInt('cart_item') ?? 0;
    // _totalPrice = prefs.getDouble('total_price') ?? 0.0;
    // _subTotalPrice = prefs.getDouble('sub_total_price') ?? 0.0;
    // _tax = prefs.getDouble('tax') ?? 0.0;
    // _cashDiscount = prefs.getDouble('cash_discount') ?? 0.0;
    // _taxPercentage = prefs.getDouble('tax_percentage') ?? 0.0;
    notifyListeners();
  }

  void addSubTotalPrice(double salePrice) {
    _subTotalPrice = _subTotalPrice + salePrice;
    _setPrefItems();
    notifyListeners();
  }

  void removeSubTotalPrice(double salePrice) {
    _subTotalPrice = _subTotalPrice - salePrice;
    _setPrefItems();
    notifyListeners();
  }

  void addTotalPrice(double salePrice) {
    _totalPrice = _totalPrice + salePrice;
    _setPrefItems();
    notifyListeners();
  }

  void removeTotalPrice(double salePrice) {
    _totalPrice = _totalPrice - salePrice;
    _setPrefItems();
    notifyListeners();
  }

  double getSubTotalPrice() {
    _getPrefItems();
    return _subTotalPrice;
  }

  double getTotalPrice() {
    _getPrefItems();
    return _totalPrice;
  }


  void addCounter() {
    if (_counter >= 0) {
      _counter = _counter + 1;
      _setPrefItems();
      notifyListeners();
    } else {}
  }

  void removerCounter() {
    if (_counter > 0) {
      _counter = _counter - 1;
      _setPrefItems();
      notifyListeners();
    } else {}
  }

  int getCounter() {
    _getPrefItems();
    return _counter;
  }

}
