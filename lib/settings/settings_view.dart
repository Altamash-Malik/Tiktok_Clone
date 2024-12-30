import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/Home_food/home_view_model.dart';
import 'package:tiktok_clone/main.dart';
import 'package:tiktok_clone/reels/upload_view2.dart';
import 'package:tiktok_clone/reels/upload_view_model.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Settings")),
        foregroundColor: Colors.white,
        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
        color: Colors.white,
        child: const Column(
          children: [
            Card(
              child: ListTile(
                leading:  CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person,color: Colors.pinkAccent,)),
                title: Text("Person Information"),
                trailing: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.star,color: Colors.pinkAccent,)),
              ),
            ),
            Card(
              child: ListTile(
                leading:  CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.point_of_sale,color: Colors.pinkAccent,)),
                title: Text("Loyalty Points"),
                trailing: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.info_rounded,color: Colors.pinkAccent,)),
              ),
            )
          ],
        ),
      ),
    );
  }
  
}