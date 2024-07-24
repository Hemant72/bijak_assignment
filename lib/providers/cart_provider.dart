import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_item.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
    (ref) => CartNotifier());

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addItem(CartItem item) {
    state = [...state, item];
  }

  void removeItem(CartItem item) {
    state = state.where((cartItem) => cartItem.name != item.name).toList();
  }

  void updateItemQuantity(CartItem item, int quantity) {
    state = state.map((cartItem) {
      if (cartItem.name == item.name) {
        return CartItem(
          name: cartItem.name,
          weight: cartItem.weight,
          price: cartItem.price,
          image: cartItem.image,
          quantity: quantity,
        );
      }
      return cartItem;
    }).toList();
  }

  double get totalPrice {
    return state.fold(
        0,
        (total, current) =>
            total +
            double.parse(current.price.substring(1)) * current.quantity);
  }

  int get totalItems {
    return state.fold(0, (total, current) => total + current.quantity);
  }
}
