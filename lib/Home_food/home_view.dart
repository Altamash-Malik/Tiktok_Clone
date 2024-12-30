import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/Home_food/Menu/menu_view.dart';
import 'package:tiktok_clone/Home_food/home_view_model.dart';
import 'package:tiktok_clone/main.dart';
import 'package:tiktok_clone/reels/upload_view2.dart';
import 'package:tiktok_clone/reels/upload_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';


class FoodPage extends ConsumerStatefulWidget {
  const FoodPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FoodPageState();
}

class _FoodPageState extends ConsumerState<FoodPage> {
@override 
  void initState() {
    super.initState();
    final viewModel=ref.read(foodViewModelProvider);
    viewModel.getPostApi();
  }
  @override
  Widget build(BuildContext context) {
        final viewModel=ref.watch(foodViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Food")),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search Restaurants...",
                prefixIcon: const Icon(Icons.search, color: Colors.pinkAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.pinkAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.pinkAccent, width: 2),
                ),
              ),
              onChanged: (query) {
                viewModel.filterRestaurants(query);
              },
            ),
          ),
          Expanded(
            child: viewModel.ResturantsList.isEmpty
                ? const Center(child: CircularProgressIndicator()) 
                :Container(
                  color: Colors.white,
                  child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: const Text("**Featured Resturants**",style: const TextStyle(color: Colors.pinkAccent,fontWeight: FontWeight.bold),)),
                              Row(
                                children: [
                                  for (var restaurant in viewModel.ResturantsList)
                                    if (restaurant.featured == true)
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: TextButton(
                                          onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const MenuPage()));
                                          },
                                          child: Card(
                                            color: const Color.fromARGB(255, 247, 245, 245),
                                            elevation: 90,
                                            shadowColor:  Colors.pinkAccent,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(16), 
                                                side: const BorderSide(
                                                  color: Colors.black, 
                                                  width: 0.1, 
                                                ),
                                              ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Center(
                                                    child: CachedNetworkImage(
                                                      imageUrl: 'https://example.com/image.jpg',
                                                      placeholder: (context, url) => const CircularProgressIndicator(),
                                                      errorWidget: (context, url, error) => const Icon(Icons.error, size: 50, color: Colors.red),
                                                    
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 250,
                                                    child: ListTile(
                                                      leading: const CircleAvatar(
                                                        backgroundColor: Colors.white,
                                                        child: Icon(Icons.restaurant,color: Colors.pinkAccent,),
                                                      ),
                                                      title: Text("${restaurant.name!}-${restaurant.location!}",style: const TextStyle(fontWeight: FontWeight.bold),),
                                                    subtitle:const Text("Food Type"),
                                                    trailing: const Icon(Icons.star_border),                                                     ),
                                                  ),  
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 11),
                        Expanded(
                          child: viewModel.filteredResturantsList.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : Column(
                            children: [
                              Container(
                              alignment: Alignment.center,
                              child: const Text("**All Resturants**",style: const TextStyle(color: Colors.pinkAccent,fontWeight: FontWeight.bold),),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: viewModel.filteredResturantsList.length,
                                    itemBuilder: (context, index) {
                                      final restaurant = viewModel.filteredResturantsList[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: TextButton(
                                          onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const MenuPage()));
                                          },
                                          child: Card(
                                          color: const Color.fromARGB(255, 247, 245, 245),
                                              elevation: 90,
                                              shadowColor:   Colors.pinkAccent,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(16), 
                                                  side: const BorderSide(
                                                    color: Colors.black, 
                                                    width: 0.1, 
                                                  ),
                                                ),
                                                                              child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                     child: CachedNetworkImage(
                                                        imageUrl: 'https://example.com/image.jpg',
                                                        placeholder: (context, url) => const CircularProgressIndicator(),
                                                        errorWidget: (context, url, error) => const Icon(Icons.error, size: 50, color: Colors.red),
                                                       ),
                                                                                             ),
                                                    ListTile(
                                                      leading: const CircleAvatar(
                                                          backgroundColor: Colors.white,
                                                          child: Icon(Icons.restaurant,color: Colors.pinkAccent,),
                                                        ),
                                                      title: Text("${restaurant.name!}-${restaurant.location!}",style: const TextStyle( fontWeight: FontWeight.bold),),
                                                    subtitle:const Text("Food Type"),
                                                    trailing: const Icon(Icons.star_border),
                                                    ),                                  
                                                  ],
                                                ),
                                              ),
                                            ),
                                        ),
                                      );
                                      }
                                    ),
                                  ),
                                ],
                              ),
                        ),
                      ],
                    ),
                ),
          ),
        ],
      ),
    );
  }
}
        
