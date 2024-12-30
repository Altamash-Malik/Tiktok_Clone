import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final menuViewModelProvider =
    ChangeNotifierProvider.autoDispose<MenuViewModel>((ref) {
  return MenuViewModel(ref);
});

class MenuViewModel extends ChangeNotifier {
  final Ref ref;
  MenuViewModel(this.ref);
 
}