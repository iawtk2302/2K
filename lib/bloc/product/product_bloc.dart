import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:sneaker_app/modal/brand.dart';
import 'package:sneaker_app/modal/category.dart';
import 'package:sneaker_app/modal/product.dart';
import 'package:sneaker_app/model/favorite.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductLoading()) {
    on<LoadProduct>((event, emit) async {
      emit(ProductLoading());

      // int count = 0;
      List<Product> listProduct = [];
      final docCategory =
          await FirebaseFirestore.instance.collection('Category');
      final docProduct = await FirebaseFirestore.instance.collection('Product');

      final List<String> idCategory = [];
      final List<Category> listCategory = [];

      await docCategory
          .where('idBrand', isEqualTo: event.idBrand)
          .get()
          .then((value) => value.docs.forEach((element) {
                idCategory.add(element.data()['idCatagory']);
                // listCategory.add(Category(
                //   idBrand: element.get('idBrand'),
                //   idCategory: element.get('idCatagory'),
                //   name: element.get('name'),
                // ));
                listCategory.add(Category.fromJson(element.data()));
              }));

      await docProduct
          .where('idCategory', whereIn: idCategory)
          .get()
          .then((value) => value.docs.forEach((element) {
                // print(element.id + element.data().toString());
                // listProduct.add(Product(
                //     gender: element.get('gender') as List<dynamic>,
                //     idCategory: element.get('idCategory'),
                //     description: element.get('description'),
                //     name: element.get('name'),
                //     image: element.get('image') as List<dynamic>,
                //     price: element.get('price')));
                listProduct.add(Product.fromJson(element.data()));
              }));

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        await Future.wait(listProduct
            .map((e) => cacheImage(event.context, e.image![0]))
            .toList());
      });
      listCategory.insert(
          0, Category(idCategory: 'All', idBrand: 'null', name: 'All'));
      // await Future.delayed(Duration(seconds: 1));
      emit(ProductLoaded(
          gender: event.gender,
          listCategory: listCategory,
          listProduct: listProduct,
          sortBy: event.sortBy));
    });

    on<ReLoadProduct>((event, emit) async {
      List<Product> listProduct = [];
      final docProduct = await FirebaseFirestore.instance.collection('Product');
      if (event.idCategory != 'All') {
        await docProduct
            .where('idCategory', isEqualTo: event.idCategory)
            .get()
            .then((value) => value.docs.forEach((element) {
                  listProduct.add(Product.fromJson(element.data()));
                }));
      } else {
        List<String> listIdCategory = [];
        event.listCategory.forEach((element) {
          listIdCategory.add(element.idCategory!);
        });
        await docProduct
            .where('idCategory', whereIn: listIdCategory)
            .get()
            .then((value) => value.docs.forEach((element) {
                  listProduct.add(Product.fromJson(element.data()));
                }));
      }

      print(event.gender);

      List<Product> rsListProduct = [];

      listProduct.forEach((element) {
        if (element.gender!
            .any((element1) => event.gender.contains(element1))) {
          rsListProduct.add(element);
        }
      });

      // print(event.sortBy);
      emit(ProductLoaded(
          gender: event.gender,
          listCategory: event.listCategory,
          listProduct: rsListProduct,
          sortBy: event.sortBy));
    });

    on<ReactProduct>((event, emit) async {
      final docFavorite =
          await FirebaseFirestore.instance.collection('Favorite');

      final doc = docFavorite
          .where('idProduct', isEqualTo: event.idProduct)
          .get()
          .then((value) {
        if (value.docs.length == 0) {
          docFavorite
              .add({'idUser': event.idUser, 'idProduct': event.idProduct})
              .then((value) =>
                  docFavorite.doc(value.id).update({'idFavorite': value.id}))
              .then((value) => print('successful'));
        } else {
          docFavorite
              .where('idProduct', isEqualTo: event.idProduct)
              .where('idUser', isEqualTo: event.idUser)
              .get()
              .then((value) => value.docs.forEach((element) {
                    element.reference.delete();
                  }));
        }
      });
    });
    on<Sort_Filter_Product>((event, emit) => {
          emit(ProductLoading()),
          // print(event.gender),
          // emit(ProductLoaded(
          //     gender: event.gender,
          //     listCategory: event.listCategory,
          //     listProduct: event.listProduct,
          //     sortBy: event.sortBy))
        });
  }

  Future cacheImage(BuildContext context, String e) =>
      precacheImage(CachedNetworkImageProvider(e), context);
}
