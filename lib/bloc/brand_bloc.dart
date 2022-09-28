import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../modal/brand.dart';

part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  BrandBloc() : super(BrandLoading()) {
    on<LoadBrand>((event, emit) async {
      emit(BrandLoading());

      List<Brand> tempList = [];

      final docBrand = await FirebaseFirestore.instance.collection('Brand');

      await docBrand.get().then((value) => value.docs.forEach((element) {
            tempList.add(Brand(
                id: element.get('id'),
                name: element.get('name'),
                imageUrl: element.get('imageUrl')));
          }));
      tempList.add(Brand(
          id: 'jasfw',
          name: 'More',
          imageUrl: 'https://cdn-icons-png.flaticon.com/512/8469/8469246.png'));
      emit(BrandLoaded(listBrand: tempList));
    });
  }
}
