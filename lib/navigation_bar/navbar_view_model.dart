import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/Home_food/home_view.dart';
import 'package:tiktok_clone/cart/cart_view.dart';
import 'package:tiktok_clone/main.dart';
import 'package:tiktok_clone/navigation_bar/navbar_view.dart';
import 'package:tiktok_clone/reels/upload_view.dart';
import 'package:tiktok_clone/reels/upload_view2.dart';
import 'package:tiktok_clone/settings/settings_view.dart';


final navViewModelProvider =
    ChangeNotifierProvider.autoDispose<NavViewModel>((ref) {
  return NavViewModel(ref);
});
class NavViewModel extends ChangeNotifier {
  final Ref ref;
  NavViewModel(this.ref);

  onItemTapped(int index,BuildContext context){
      if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> NavPage()));
      print("HomePage");
    } else if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> UploadPage()));  
            print("UploadPage");
 } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> FoodPage()));
            print("FoodPage");  
 } else if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsPage())); 
            print("SettingPage"); 
 }
  }
}