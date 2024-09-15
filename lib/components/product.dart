import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String image;
  final String name;
  final String description;
  final double price;
  final String category;
  final int stock;

  const Product({
    this.id = "",
    this.image = "",
    this.name = "",
    this.description = "",
    this.price = 0.0,
    this.stock = 0,
    this.category = "",
  });

  @override
  List<Object?> get props => [id];
}
