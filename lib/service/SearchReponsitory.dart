import 'package:cloud_firestore/cloud_firestore.dart';

class SearchReponsitory{
  searchProduct(String queryText)async{
    await FirebaseFirestore.instance
          .collection('Product')
          .where('name',isGreaterThan:queryText)
          .where('name',isLessThan:queryText+ '\uf8ff').get().then((value) => value);
  }
}