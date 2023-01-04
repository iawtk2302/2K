import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sneaker_app/model/favorite.dart';

import '../model/product.dart';

class FavoriteRepository {
  Future<List<Product>> loadProductFavorite(List<String> favorites) async {
    List<Product> products = [];
    if (favorites.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('Product')
          .where('idProduct', whereIn: favorites)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          // print(element.data());
          products.add(Product.fromJson(element.data()));
        });
      });
    }
    return products;
    // print(favorites);
  }
}
