import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sneaker_app/model/detail_order.dart';
import 'package:sneaker_app/model/order.dart';
import 'package:sneaker_app/service/my_order_repository.dart';

import '../../model/detail_product.dart';

part 'my_order_event.dart';
part 'my_order_state.dart';

class MyOrderBloc extends Bloc<MyOrderEvent, MyOrderState> {
  MyOrderRepository myOrderRepository = MyOrderRepository();
  MyOrderBloc() : super(MyOrderLoading()) {
    on<LoadMyOrder>((event, emit) {
      emit(MyOrderLoading());
      myOrderRepository
          .loadMyOrder()
          .listen((event) => add(UpdateMyOrder(listOrder: event)));
    });

    on<UpdateMyOrder>(
        (event, emit) => {emit(MyOrderLoaded(listOrder: event.listOrder))});
  }
}
