import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final foodViewModelProvider =
    ChangeNotifierProvider.autoDispose<FoodViewModel>((ref) {
  return FoodViewModel(ref);
});
class FoodViewModel extends ChangeNotifier {
  final Ref ref;
  FoodViewModel(this.ref);
  List<Resturants> ResturantsList = [];
  List<Resturants> filteredResturantsList = [];

  Future<List<Resturants>> getPostApi() async {
    final response =
        await http.get(Uri.parse('apikey'));
    var data = jsonDecode(response.body.toString());
    ResturantsList = (data as List).map((e) => Resturants.fromJson(e)).toList();
    filteredResturantsList = List.from(ResturantsList);
    notifyListeners();
    if (response.statusCode == 200) {
      return ResturantsList;
    } else {
      return ResturantsList;
    }
  }
  void filterRestaurants(String query) {
    if (query.isEmpty) {
      filteredResturantsList = List.from(ResturantsList);
    } else {
      filteredResturantsList = ResturantsList.where((restaurant) {
        return restaurant.name!.contains(query) || restaurant.location!.contains(query);
      }).toList();
    }
    notifyListeners();
  }
}
 


//MOCK API MODEL>>>
class Resturants {
  bool? featured;
  String? name;
  String? location;
  String? resturantId;

  Resturants({this.featured, this.name, this.location, this.resturantId});

  Resturants.fromJson(Map<String, dynamic> json) {
    featured = json['featured'];
    name = json['name'];
    location = json['location'];
    resturantId = json['resturantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['featured'] = this.featured;
    data['name'] = this.name;
    data['location'] = this.location;
    data['resturantId'] = this.resturantId;
    return data;
  }
}
