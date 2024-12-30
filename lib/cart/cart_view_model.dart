import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final cartViewModelProvider =
    ChangeNotifierProvider.autoDispose<CartViewModel>((ref) {
  return CartViewModel(ref);
});
class CartViewModel extends ChangeNotifier {
  final Ref ref;
  CartViewModel(this.ref);
  List selectedItems =[];
Future addToCart(String name,String prize) async {
  selectedItems.add({'Name': name,'prize':prize});
  notifyListeners();
  print(selectedItems);
}
 
}