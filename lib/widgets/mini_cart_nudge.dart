import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/cart_provider.dart';

class MiniCartNudge extends ConsumerWidget {
  const MiniCartNudge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    if (cart.isEmpty) {
      return const SizedBox.shrink();
    }

    final totalPrice = ref.read(cartProvider.notifier).totalPrice;
    final totalItems = ref.read(cartProvider.notifier).totalItems;

    return Container(
      height: 60,
      color: Colors.green,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Items in Cart: $totalItems',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            'Total: \$${totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
