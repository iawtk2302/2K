import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:sneaker_app/model/order.dart';
import 'package:sneaker_app/model/product.dart';
import 'package:sneaker_app/model/product_cart.dart';

import '../../model/detail_order.dart';

part 'list_order_event.dart';
part 'list_order_state.dart';

class ListOrderBloc extends Bloc<ListOrderEvent, ListOrderState> {
  ListOrderBloc() : super(ListOrderLoading()) {
    on<LoadListOrder>((event, emit) async {
      emit(ListOrderLoading());

      List<Product> listProduct = [];
      final List<DetailOrder> listDetailOrder = [];
      final List<ProductCart> listProductCart = [];

      final docDetailOrder =
          FirebaseFirestore.instance.collection('DetailOrder');
      final docProduct = FirebaseFirestore.instance.collection('Product');
      await docDetailOrder
          .where('idOrder', isEqualTo: event.order.idOrder)
          .get()
          .then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          listDetailOrder.add(DetailOrder.fromJson(value.docs[i].data()));
        }
      }).then((value) {
        List<String> listTemp =
            listDetailOrder.map((e) => e.idProduct.toString()).toList();
        docProduct.where('idProduct', whereIn: listTemp).get().then((value) {
          for (int j = 0; j < value.docs.length; j++) {
            listProduct.add(Product.fromJson(value.docs[j].data()));
          }
        }).then((value) {
          for (int i = 0; i < listDetailOrder.length; i++) {
            listProductCart.add(ProductCart(
                product: listProduct[i],
                amount: listDetailOrder[i].amount,
                size: listDetailOrder[i].size));
          }
        });
      });
      await Future.delayed(Duration(seconds: 1));
      emit(ListOrderLoaded(listProduct: listProductCart));
    });
  }
}
