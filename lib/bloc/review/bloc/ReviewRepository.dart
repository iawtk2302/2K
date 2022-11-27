import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sneaker_app/model/product.dart';

import '../../../model/review.dart';

class ReviewRepository{
  final reviews = FirebaseFirestore.instance.collection('Review');
  getReviewProduct(Product product)async{
    List<Review> listReview=[];
    await reviews.where('idProduct',isEqualTo: product.idProduct).get().then((value){
      value.docs.forEach((element) {listReview.add(Review.fromJson(element.data()));});
    });
    return listReview;
  }
}