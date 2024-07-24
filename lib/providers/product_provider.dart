import 'package:bijak_assignment/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productProvider = Provider<List<Product>>((ref) {
  return [
    Product(
        name: 'Rice',
        weight: '1kg',
        price: '\$10',
        image: 'assets/product1.jpg'),
    Product(
        name: 'Sugar',
        weight: '500g',
        price: '\$5',
        image: 'assets/product2.jpg'),
    // Add more products as needed
  ];
});
