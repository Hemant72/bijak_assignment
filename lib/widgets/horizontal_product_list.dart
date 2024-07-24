import 'package:bijak_assignment/models/cart_item.dart';
import 'package:bijak_assignment/providers/cart_provider.dart';
import 'package:bijak_assignment/providers/product_provider.dart';
import 'package:bijak_assignment/screens/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HorizontalProductList extends ConsumerWidget {
  const HorizontalProductList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productProvider);
    final cart = ref.watch(cartProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Recently Ordered',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        const SizedBox(height: 8),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
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
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 3)
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        product.image,
                        width: 150,
                        height: 96,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
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
                            const Flexible(child: SizedBox.shrink()),
                            if (isInCart)
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      final newQuantity =
                                          cartItem!.quantity - 1;
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
                              Center(
                                child: ElevatedButton(
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
                              ),
                          ],
                        ),
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
