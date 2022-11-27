import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sneaker_app/model/detail_order.dart';

import '../model/order.dart';

class MyOrderRepository {
  Stream<List<Order>> loadMyOrder() {
    return FirebaseFirestore.instance
        .collection('Order')
        .where('idUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((event) {
      return event.docs.map((e) => Order.fromJson(e.data())).toList();
    });
  }

  void updateStateOrder(Order order, String state) {
    try {
      FirebaseFirestore.instance.collection('Order').doc(order.idOrder).update({
        'state': state,
        'dateCanceled': DateTime.now(),
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // Future<List<DetailOrder>> loadDetailOrder(List<Order> idOrder) async {
  //   List<String> listTemp = [];
  //   List<DetailOrder> result = [];
  //   idOrder.forEach((element) {
  //     listTemp.add(element.idOrder.toString());
  //   });

  //   await FirebaseFirestore.instance
  //       .collection('DetailOrder')
  //       .where('idOrder', whereIn: listTemp)
  //       .get()
  //       .then((value) {
  //     value.docs.forEach((element) {
  //       DetailOrder detailOrder = DetailOrder.fromJson(element.data());
  //       // print(detailOrder.idProduct);
  //       result.add(detailOrder);
  //     });
  //   });

  //   return result;
  // }
}
