import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/Home_food/home_view.dart';
import 'package:tiktok_clone/cart/cart_view.dart';
import 'package:tiktok_clone/navigation_bar/navbar_view_model.dart';
import 'package:tiktok_clone/reels/upload_view.dart';
import 'package:tiktok_clone/settings/settings_view.dart';

class NavPage extends ConsumerStatefulWidget{
  const NavPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NavPageState();
}

class _NavPageState extends ConsumerState<NavPage>{
  @override
  Widget build(BuildContext context) {
    final viewModel= ref.watch(navViewModelProvider);
    int selectedIndex=0;
      return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: const Text("Home"),
          ),
          backgroundColor: Colors.pinkAccent,
          foregroundColor: Colors.white,
        ),
        body:Container(
          color: Colors.white,
          child: Column( 
            children: [
              Expanded(
                child: 
                    Center(
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 100,
                              width: 100,
                              color: Colors.white,
                              alignment: Alignment.center,
                              child: Center(
                                child: Column(
                                  children: [
                                    Row(
                                    children: [
                                      Card(
                                        color: Colors.white,
                                        child: IconButton(onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>NavPage()));
                                        },style: IconButton.styleFrom(
                                          backgroundColor: Colors.pinkAccent,
                                        ), 
                                        icon: Icon(Icons.home,color: Colors.white,)),
                                      ),
                                      Card(
                                        color: Colors.white,
                                        child: IconButton(onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodPage()));
                                        },style: IconButton.styleFrom(
                                          backgroundColor: Colors.pinkAccent,
                                        ), icon: Icon(Icons.food_bank,color: Colors.white,)),
                                      )
                                    ],
                                    ),
                                    Row(
                                      children: [
                                        Card(
                                          color: Colors.white,
                                          child: IconButton(onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadPage()));
                                          }, style: IconButton.styleFrom(
                                            backgroundColor: Colors.pinkAccent
                                          ),icon: Icon(CupertinoIcons.video_camera_solid,color: Colors.white,)),
                                        ),
                                        Card(
                                          color: Colors.white,
                                          child: IconButton(onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsPage()));
                                          },style: IconButton.styleFrom(
                                            backgroundColor: Colors.pinkAccent
                                          ), icon: Icon(Icons.settings,color: Colors.white,)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                          ),
                          SizedBox(height: 20,),
                      ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const NavPage()));
                      },style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent
                      ), child: const Text("Welcome to Food and Reels",style: TextStyle(color: Colors.white),)),
                      const SizedBox(height: 10,),
                      ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const UploadPage()));
                      },style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent
                      ), child: const Text("Go to Reels Section",style: TextStyle(color: Colors.white),)),
                      const SizedBox(height: 10,),
                      ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const FoodPage()));
                      },style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent
                      ), child: const Text("Order Your Food",style: TextStyle(color: Colors.white),)),
                      const SizedBox(height: 10,),
                      ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const SettingsPage()));
                      },style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent
                      ), child: const Text("Settings",style: TextStyle(color: Colors.white),)),
                        ],
                      ),
                      
                    ),
                ),
              
           BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home,color: Colors.white,),
               label: 'Home',
              backgroundColor: Colors.pinkAccent,
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.video_camera_solid,color: Colors.white,),
              label: 'Reels',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.food_bank,color: Colors.white,),
              label: 'Food',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings,color: Colors.white,),
              label: 'Settings',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.white,
          onTap:(int index) {
            setState(() {
              selectedIndex = index;
            });
            viewModel.onItemTapped(index, context);
          },
                ),
            ]
          ),
        ),
      );
  }
}