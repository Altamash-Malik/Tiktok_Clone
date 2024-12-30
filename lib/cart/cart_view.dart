import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/cart/cart_view_model.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuPageState();
}

class _MenuPageState extends ConsumerState<CartPage> {
@override
void initState() {
  super.initState();
  final viewModel = ref.read(cartViewModelProvider);
}

  @override
  Widget build(BuildContext context) {
    
  final viewModel = ref.watch(cartViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Cart")),
        foregroundColor: Colors.pinkAccent,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                      itemCount: viewModel.selectedItems.length,
                      itemBuilder: (context, index) {
                        final item = viewModel.selectedItems[index];
                        return Card(
                          color: Colors.pinkAccent,
                                      elevation: 90,
                                      shadowColor:   Colors.pinkAccent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16), 
                                          side: const BorderSide(
                                            color: Colors.black, 
                                            width: 1, 
                                          ),
                                        ),
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.food_bank_outlined,color: Colors.pinkAccent),
                            ),
                            title: Text(item['Name']),
                            trailing: Text(item['prize']),
                          ),
                        );
                      }
              ),
            ),
            ElevatedButton(onPressed: (){}, 
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent
            ),
            child: const Text("Order Completed",style: TextStyle(color: Colors.white),)),
            const SizedBox(height: 50,),
          ],
        ),
      )
    );
  }
}
