import 'package:bijak_assignment/models/cart_item.dart';
import 'package:bijak_assignment/models/product.dart';
import 'package:bijak_assignment/providers/cart_provider.dart';
import 'package:bijak_assignment/widgets/mini_cart_nudge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailPage extends ConsumerWidget {
  final Product product;

  const ProductDetailPage(this.product, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final isInCart = cart.any((item) => item.name == product.name);
    final cartItem =
        isInCart ? cart.firstWhere((item) => item.name == product.name) : null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Product Details'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  product.image,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 2 / 3,
                ),
                const SizedBox(height: 8),
                Text(product.name,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Text(product.weight,
                    style: const TextStyle(fontSize: 14, color: Colors.grey)),
                Text(product.price,
                    style: const TextStyle(fontSize: 14, color: Colors.grey)),
                const Text(
                  'This is a detailed description of the product.',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  children: [
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
                                    .updateItemQuantity(cartItem, newQuantity);
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
                          ref.read(cartProvider.notifier).addItem(CartItem(
                                name: product.name,
                                weight: product.weight,
                                price: product.price,
                                image: product.image,
                              ));
                        },
                        child: const Text('Add to cart'),
                      ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: MiniCartNudge(),
          ),
        ],
      ),
    );
  }
}
