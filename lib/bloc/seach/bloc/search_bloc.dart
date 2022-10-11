import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../modal/brand.dart';
import '../../../modal/product.dart';
import '../../../service/SearchReponsitory.dart';


part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchLoading()) {
    on<LoadProductSearch>((event, emit) async {
      emit(SearchLoading());
      List<String> listBrand=['All'];
      List<String> listGender=['All','Men','Women'];
      List<String> listSort=['Price High','Price Low'];
      await FirebaseFirestore.instance.collection('Brand').get().then((value) {
        listBrand.addAll(value.docs.map((e) => Brand.fromJson(e.data()).name.toString()).toList());});
      List<Product> listProduct=await SearchReponsitory().searchProduct(event.query);
      emit(SearchLoaded(listProduct, listBrand, listGender, listSort));
    });
    on<FilterProduct>((event, emit) async {
      final state=this.state as SearchLoaded;
      emit(SearchLoading());
      List<Product> listProduct=await SearchReponsitory().filterProduct(event.queryText,event.brand,event.gender,event.priceRange,event.sort);
      emit(SearchLoaded(listProduct, state.listBrand, state.listGender, state.listSort));
    });
  }
}
