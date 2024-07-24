class CartItem {
  final String name;
  final String weight;
  final String price;
  final String image;
  int quantity;

  CartItem({
    required this.name,
    required this.weight,
    required this.price,
    required this.image,
    this.quantity = 1,
  });
}
