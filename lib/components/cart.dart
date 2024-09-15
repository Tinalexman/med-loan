import 'package:med_loan/components/product.dart';

class CartOrder {
  final Product product;
  final int quantity;

  const CartOrder({
    required this.product,
    this.quantity = 1,
  });

  CartOrder withNewQuantity(int newQuantity) {
    return CartOrder(product: product, quantity: newQuantity);
  }
}
