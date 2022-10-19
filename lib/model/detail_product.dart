import 'package:equatable/equatable.dart';

class DetailProduct extends Equatable {
  String? idProduct;
  String? idDetailProduct;
  double? size;
  int? amount;

  DetailProduct({this.idProduct, this.idDetailProduct, this.size, this.amount});

  DetailProduct.fromJson(Map<String, dynamic> json) {
    idProduct = json['idProduct'];
    idDetailProduct = json['idDetailProduct'];
    size = json['size'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idProduct'] = this.idProduct;
    data['idDetailProduct'] = this.idDetailProduct;
    data['size'] = this.size;
    data['amount'] = this.amount;
    return data;
  }

  @override
  List<Object?> get props => [idProduct, idDetailProduct, amount, size];
}
