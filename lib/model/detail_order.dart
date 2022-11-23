import 'dart:ffi';

import 'package:equatable/equatable.dart';

class DetailOrder extends Equatable {
  String? idOrder;
  String? idProduct;
  String? idDetailOrder;
  double? size;
  int? amount;

  DetailOrder({this.idOrder, this.idProduct, this.idDetailOrder});

  DetailOrder.fromJson(Map<String, dynamic> json) {
    idOrder = json['idOrder'];
    idProduct = json['idProduct'];
    idDetailOrder = json['idDetailOrder'];
    size = double.parse(json['size'].toString());
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idOrder'] = this.idOrder;
    data['idProduct'] = this.idProduct;
    data['idDetailOrder'] = this.idDetailOrder;
    data['size'] = this.size;
    data['amount'] = this.amount;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [idOrder, idProduct, idDetailOrder, size, amount];
}
