import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_app/modal/product.dart';

class SearchReponsitory{
  searchProduct(String queryText)async{
    List<Product>? result;
    // await FirebaseFirestore.instance
    //       .collection('Product')
    //       .where('name',isGreaterThan:queryText)
    //       .where('name',isLessThan:queryText+ '\uf8ff').get()
    //       .then((value) {
    //         result=value.docs.map((e) => Product.fromJson(e.data())).toList();
    //       });
          await FirebaseFirestore.instance
          .collection('Product')
          .get()
          .then((value) {
            result=value.docs.where((element) => element.get('name').toString().toLowerCase().contains(queryText.toString().toLowerCase())).map((e) => Product.fromJson(e.data())).toList();
          });
    return result;
  }
  filterProduct(String queryText,String brand, String gender, RangeValues priceRange, String sort)async{
    List<Product> listSearch=await searchProduct(queryText);
    List<Product>? result;
    if(brand=='All'&&gender=='All'){
      if(sort=='Price High')
      result=listSearch.where((element) => element.price!>=priceRange.start&&element.price!<=priceRange.end).toList()..sort((a, b) => a.price!.compareTo(b.price as int),);
      else
      result=listSearch.where((element) => element.price!>=priceRange.start&&element.price!<=priceRange.end).toList()..sort((a, b) => b.price!.compareTo(a.price as int),);
      // await productRef.where('name',isGreaterThan:queryText)
      //     .where('name',isLessThan:'$queryText\uf8ff');
      // await productRef.where('price',isGreaterThan: priceRange.start)
      //     .where('price',isLessThan: priceRange.end);
      // await productRef.orderBy('price').get().then((value) => result=value.docs.map((e) => Product.fromJson(e.data())).toList());
      // await FirebaseFirestore.instance
      //     .collection('Product')
      //     // .orderBy('price',descending: sort=='Price High'?true:false)
          
      //     .where('name',isGreaterThan:queryText)
      //     .where('name',isLessThan:'$queryText\uf8ff')
      //     .orderBy('name')
      //     // .orderBy('price')
      //     .where('price',isGreaterThan: priceRange.start)
      //     .where('price',isLessThan: priceRange.end)
      //     .orderBy('price')
      //     .get()
      //     .then((value) {
      //       result=value.docs.map((e) => Product.fromJson(e.data())).toList();
      //     });
    }
    else{
      if(sort=='Price High')
      result=listSearch.where((element) => element.price!>=priceRange.start&&element.price!<=priceRange.end&&element.categoryName==brand&&checkGender(element.gender!, gender)).toList()..sort((a, b) => a.price!.compareTo(b.price as int),);
      else
      result=listSearch.where((element) => element.price!>=priceRange.start&&element.price!<=priceRange.end&&element.categoryName==brand&&checkGender(element.gender!, gender)).toList()..sort((a, b) => b.price!.compareTo(a.price as int),);
    }
    return result;   
  }
  bool checkGender(List<dynamic> listGender,String gender){
    bool check=false;
    for (var element in listGender) {
      if(element.toString()==gender) {
        check=true;
      }
    }
    return check;
  }
}
