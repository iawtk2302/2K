import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:sneaker_app/modal/banner.dart';

import '../../modal/brand.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading()) {
    on<LoadHome>((event, emit) async {
      emit(HomeLoading());

      List<Brand> tempList = [];
      List<CustomBanner> tempBanner = [];
      final docBrand = await FirebaseFirestore.instance.collection('Brand');
      final docBanner = await FirebaseFirestore.instance.collection('Banner');
      await docBrand.get().then((value) => value.docs.forEach((element) {
            tempList.add(Brand(
                id: element.get('id'),
                name: element.get('name'),
                imageUrl: element.get('imageUrl')));
          }));

      await docBanner
          // .limit(1)
          .get()
          .then((value) => value.docs.forEach((element) {
                tempBanner.add(CustomBanner(
                  id: element.get('id'),
                  image: element.get('image'),
                ));
              }));
      tempList.add(Brand(
          id: 'jasfw',
          name: 'More',
          imageUrl: 'https://cdn-icons-png.flaticon.com/512/8469/8469246.png'));
      emit(HomeLoaded(listBrand: tempList, banner: tempBanner));
    });
  }
}
