import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:sneaker_app/modal/brand.dart';
import 'package:sneaker_app/modal/category.dart';
import 'package:sneaker_app/modal/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductLoading()) {
    on<LoadProduct>((event, emit) async {
      BuildContext context1;
      emit(ProductLoading());

      int count = 0;
      List<Product> listProduct = [];
      final docCategory =
          await FirebaseFirestore.instance.collection('Category');
      final List<String> idCategory = [];
      final List<Category> listCategory = [];
      await docCategory
          .where('idBrand', isEqualTo: event.idBrand)
          .get()
          .then((value) => value.docs.forEach((element) {
                idCategory.add(element.data()['idCatagory']);
                listCategory.add(Category(
                  idBrand: element.get('idBrand'),
                  idCategory: element.get('idCatagory'),
                  name: element.get('name'),
                ));
              }));
      final docProduct = await FirebaseFirestore.instance.collection('Product');
      await docProduct
          .where('idCategory', whereIn: idCategory)
          .get()
          .then((value) => value.docs.forEach((element) {
                // print(element.id + element.data().toString());
                listProduct.add(Product(
                    gender: element.get('gender') as List<dynamic>,
                    idCategory: element.get('idCategory'),
                    description: element.get('description'),
                    name: element.get('name'),
                    image: element.get('image') as List<dynamic>,
                    price: element.get('price')));
              }));
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        await Future.wait(listProduct
            .map((e) => cacheImage(event.context, e.image![0]))
            .toList());
      });
      emit(ProductLoaded(listCategory: listCategory, listProduct: listProduct));
    });
  }

  Future cacheImage(BuildContext context, String e) =>
      precacheImage(CachedNetworkImageProvider(e), context);
}
