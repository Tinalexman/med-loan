import 'package:faker/faker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:med_loan/components/cart.dart';
import 'package:med_loan/components/product.dart';
import 'package:med_loan/misc/constants.dart';

final StateProvider<List<Product>> hotDealsProvider = StateProvider(
  (ref) => List.generate(
    6,
    (index) => Product(
      id: faker.guid.guid(),
      name: faker.food.dish(),
      image: "assets/images/food.jpg",
      description: loremIpsum,
      price: 2500,
      stock: 12,
      category: "Foodstuffs",
    ),
  ),
);

final StateProvider<List<Product>> topProductsProvider = StateProvider(
  (ref) => List.generate(
    6,
    (index) => Product(
      id: faker.guid.guid(),
      name: faker.food.dish(),
      image: "assets/images/food.jpg",
      description: loremIpsum,
      price: 2500,
      category: "Foodstuffs",
      stock: 45,
    ),
  ),
);

final StateProvider<List<Product>> recentlyAddedProvider = StateProvider(
  (ref) => List.generate(
    6,
    (index) => Product(
      id: faker.guid.guid(),
      name: faker.food.dish(),
      image: "assets/images/food.jpg",
      description: loremIpsum,
      price: 2500,
      category: "Pharmaceuticals",
      stock: 13,
    ),
  ),
);

final StateProvider<List<Product>> allProductsProvider = StateProvider(
      (ref) => List.generate(
    30,
        (index) => Product(
      id: faker.guid.guid(),
      name: faker.food.dish(),
      image: "assets/images/food.jpg",
      description: loremIpsum,
      price: 2500,
      category: "Foodstuffs",
      stock: 13,
    ),
  ),
);

final StateProvider<List<CartOrder>> cartProvider = StateProvider((ref) => []);

void logout(WidgetRef ref) {
  ref.invalidate(allProductsProvider);
  ref.invalidate(cartProvider);
  ref.invalidate(topProductsProvider);
  ref.invalidate(recentlyAddedProvider);
  ref.invalidate(hotDealsProvider);
}
