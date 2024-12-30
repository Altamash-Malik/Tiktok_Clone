import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/cart/cart_view.dart';
import 'package:tiktok_clone/cart/cart_view_model.dart';

class MenuPage extends ConsumerStatefulWidget {
  const MenuPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuPageState();
}

class _MenuPageState extends ConsumerState<MenuPage> {
  
  List starters = [{'name':'Starter1','prize':'200Rs'}, {'name':'Starter2','prize':'300Rs'}, {'name':'Starter3','prize':'400Rs'}, {'name':'Starter4','prize':'500Rs'}, {'name':'Starter6','prize':'700Rs'}, {'name':'Starter7','prize':'800Rs'}, {'name':'Starter8','prize':'900Rs'}, {'name':'Starter1','prize':'200Rs'}];
  List deals = [{'name':'Deal1','prize':'1200Rs'}, {'name':'Deal2','prize':'2200Rs'},{'name':'Deal3','prize':'3200Rs'}, {'name':'Deal4','prize':'2200Rs'}, {'name':'Deal5','prize':'2000Rs'}, {'name':'Deal6','prize':'1800Rs'}];
  List fastFood = [{'name':'Burger1','prize':'800Rs'}, {'name':'Burger2','prize':'1200Rs'}, {'name':'Burger3','prize':'1100Rs'}, {'name':'Steak1','prize':'800Rs'}, {'name':'Steak2','prize':'1200Rs'}, {'name':'Steak3','prize':'1800Rs'}, {'name':'Pizza1','prize':'1800Rs'},{'name':'Pizza2','prize':'2800Rs'}];
  List bbq = [{'name':'Beef Kebab','prize':'3200Rs'}, {'name':'Mutton Kebab','prize':'4200Rs'}, {'name':'Chikken sajji','prize':'1500Rs'},{'name':'Grill Fish','prize':'5200Rs'} ,{'name': 'Malai Boti','prize':'2200Rs'}, {'name':'Chicken Kebab','prize':'2000Rs'}, {'name':'Tikka','prize':'700Rs'}];
  List tandoor = [{'name':'Sada Roti','prize':'50Rs'},{'name': 'Naan','prize':'100Rs'},{'name': 'Garlic Naan','prize':"300Rs"},{'name': 'Roghni Naan','prize':'250Rs'}];
   List beverages = [{'name':'Coke','prize':'150Rs'}, {'name':'Sprite','prize':'150Rs'},{'name': 'Fanta','prize':'150Rs'},{'name': 'Mint Margarita','prize':'350Rs'},{'name': 'Fresh Lime','prize':'250Rs'}];
   final Map<String, List<dynamic>> menuCategories = {};
   String selectedCategory='';
   static const snackBar =SnackBar(content: Text("Succesfully Added To Cart"));

@override
void initState() {
  super.initState();
  menuCategories['Starters'] = starters;
  menuCategories['Deals'] = deals;
  menuCategories['Fast Food'] = fastFood;
  menuCategories['BBQ'] = bbq;
  menuCategories['Tandoor'] = tandoor;
  menuCategories['Beverages'] = beverages;
  selectedCategory = 'Starters'; 
  final viewModel = ref.read(cartViewModelProvider);
}

  @override
  Widget build(BuildContext context) {
    
  final viewModel = ref.watch(cartViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Menu")),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const CartPage()));
          },
           icon: const Icon(CupertinoIcons.cart))
        ],
        foregroundColor: Colors.pinkAccent,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
                      SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
             children: menuCategories.keys.map((category) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedCategory = category;
                      });
                     },  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white
                     ),        
                     child: Text(category,style: const TextStyle(color: Colors.pinkAccent,backgroundColor: Colors.white)),
                    ),
                );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10,),
            Expanded(
            child: ListView.builder(
              itemCount: menuCategories[selectedCategory]?.length,
              itemBuilder: (context, index) {
                 final item =menuCategories[selectedCategory]![index];
                return  Card(
                  color: const Color.fromARGB(255, 244, 243, 243),
                                    elevation: 90,
                                    shadowColor:   Colors.pinkAccent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16), 
                                        side: const BorderSide(
                                          color: Colors.black, 
                                          width: 0.1, 
                                        ),
                                      ),
                  child:  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child:  Icon(Icons.food_bank_outlined,color: Colors.pinkAccent,),
                    ),
                    title: Text(item['name']),
                    subtitle: Text("from ${item['prize']}",style: const TextStyle(fontSize: 10,fontWeight: FontWeight.w900,color: Colors.pinkAccent),),
                    trailing: Stack(
                      children: [
                         CachedNetworkImage(
                                  imageUrl: 'https://example.com/image.jpg',
                                  placeholder: (context, url) => const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => const Icon(Icons.error, size: 50, color: Colors.red),
                                ),
                        Positioned(
                          bottom: -5,
                          right: -5,
                          child:IconButton(onPressed: (){
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  viewModel.addToCart(item['name'],item['prize']);
                                }, 
                                icon: const Icon(Icons.add)), 
                        ),
                      ],
                    ),
                    ),
                );
              },
            ),
            ),
          ],
        ),
      ),
    );
  }
}
