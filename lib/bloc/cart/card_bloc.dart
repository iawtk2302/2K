import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sneaker_app/model/cart.dart';
import 'package:sneaker_app/model/product_cart.dart';
import 'package:sneaker_app/screen/product_detail.dart';

part 'card_event.dart';
part 'card_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<LoadCart>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();

      // final success = await prefs.remove('products');
      final List<ProductCart> products = [];
      //get data from shared_preferences
      final List<String>? items = prefs.getStringList('products');
      //check not null to continue
      if (items != null) {
        items.forEach((element) {
          //add product to list products
          ProductCart product = ProductCart.fromJson(jsonDecode(element));
          products.add(product);
          // print(product);
        });
      }

      // await Future.delayed(Duration(seconds: 1));
      //emit
      emit(CartLoaded(cart: Cart(products: products)));
    });

    on<CartProductAdd>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();

      if (state is CartLoaded) {
        List<String> temp = [];
        final state = this.state as CartLoaded;

        //check product exist in list product
        if (!state.cart.products.contains(event.product)) {
          //update to shared_preferences
          state.cart.products.forEach((element) {
            temp.add(jsonEncode(element));
          });
          temp.add(jsonEncode(event.product));
          await prefs.setStringList('products', temp);

          //emit
          emit(CartLoaded(
              cart: Cart(
                  products: List.from(state.cart.products)
                    ..add(event.product))));
        } else {
          List<ProductCart> listTemp = List.from(state.cart.products);

          //get amount of element which equal with product of event
          int amountTemp = listTemp[state.cart.products.indexWhere(
                  (element) => element.product == event.product.product)]
              .amount!;

          //increase amount
          amountTemp += event.product.amount!;

          //update amount to product
          listTemp[state.cart.products.indexWhere(
                  (element) => element.product == event.product.product)]
              .amount = amountTemp;

          //update to shared_preference
          listTemp.forEach((element) {
            temp.add(jsonEncode(element));
          });
          await prefs.setStringList('products', temp);

          //emit
          emit(CartLoaded(cart: Cart(products: listTemp)));
        }
      }
    });

    on<CartProductRemove>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      if (state is CartLoaded) {
        final state = this.state as CartLoaded;

        final List<ProductCart> products = [];
        //get from shared_preferences
        final List<String>? items = prefs.getStringList('products');
        //add to list product then remove
        items!.forEach((element) {
          ProductCart product = ProductCart.fromJson(jsonDecode(element));
          products.add(product);
        });
        //remove product from list
        products.remove(event.product);

        //update to shared_preferences
        List<String> temp = [];
        products.forEach((element) async {
          temp.add(jsonEncode(element));
        });
        await prefs.setStringList('products', temp);
        //emit
        emit(CartLoaded(
            cart: Cart(
                products: List.from(state.cart.products)
                  ..remove(event.product))));
      }
    });
    on<CartProductUpdate>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      if (state is CartLoaded) {
        final state = this.state as CartLoaded;
        //List Temp Products
        final List<String> temp = [];
        //get from shared_preferences
        final List<String>? items = prefs.getStringList('products');
        //add to list product then remove
        List<ProductCart> listTemp = List.from(state.cart.products);

        //get amount of element which equal with product of event
        int amountTemp = listTemp[state.cart.products.indexWhere(
                (element) => element.product == event.product.product)]
            .amount!;

        //increase amount
        amountTemp = event.product.amount!;

        //update amount to product
        listTemp[state.cart.products.indexWhere(
                (element) => element.product == event.product.product)]
            .amount = amountTemp;

        //update to shared_preference
        listTemp.forEach((element) {
          temp.add(jsonEncode(element));
        });
        await prefs.setStringList('products', temp);

        //emit
        emit(CartLoading());

        emit(CartLoaded(cart: Cart(products: listTemp)));
      }
    });
  }
}
