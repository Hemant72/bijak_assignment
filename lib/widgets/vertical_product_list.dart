import 'package:bijak_assignment/models/cart_item.dart';
import 'package:bijak_assignment/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/product_provider.dart';
import '../screens/product_detail_page.dart';

class VerticalProductList extends ConsumerWidget {
  const VerticalProductList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productProvider);
    final cart = ref.watch(cartProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Seasonal Products',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        const SizedBox(height: 8),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final isInCart = cart.any((item) => item.name == product.name);
              final cartItem = isInCart
                  ? cart.firstWhere((item) => item.name == product.name)
                  : null;

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(product),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 3)
                    ],
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        product.image,
                        width: 96,
                        height: 96,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black)),
                          Text(product.weight,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey)),
                          Text(product.price,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey)),
                          const SizedBox(
                              height: 8), // Add spacing instead of Spacer
                          if (isInCart)
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    final newQuantity = cartItem!.quantity - 1;
                                    if (newQuantity > 0) {
                                      ref
                                          .read(cartProvider.notifier)
                                          .updateItemQuantity(
                                              cartItem, newQuantity);
                                    } else {
                                      ref
                                          .read(cartProvider.notifier)
                                          .removeItem(cartItem);
                                    }
                                  },
                                ),
                                Text('${cartItem!.quantity}'),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    ref
                                        .read(cartProvider.notifier)
                                        .updateItemQuantity(
                                            cartItem, cartItem.quantity + 1);
                                  },
                                ),
                              ],
                            )
                          else
                            ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(cartProvider.notifier)
                                    .addItem(CartItem(
                                      name: product.name,
                                      weight: product.weight,
                                      price: product.price,
                                      image: product.image,
                                    ));
                              },
                              child: const Text('Add to cart'),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
