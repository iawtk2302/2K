import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteRepository {
  loadProductFavorite() async {
    await FirebaseFirestore.instance
        .collection('Product')
        .get()
        .then((value) {});
  }
}
