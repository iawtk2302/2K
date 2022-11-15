import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  String? idOrder;
  String? idUser;
  String? idAddress;
  int? total;
  String? state;
  String? idVoucher;
  String? note;
  Timestamp? dateCreated;
  Timestamp? dateCompleted;

  Order({
    this.idOrder,
    this.idUser,
    this.idAddress,
    this.total,
    this.state,
    this.idVoucher,
    this.note,
    this.dateCreated,
    this.dateCompleted,
  });

  Order.fromJson(Map<String, dynamic> json) {
    idOrder = json['idOrder'];
    idUser = json['idUser'];
    idAddress = json['idAddress'];
    total = json['total'];
    state = json['state'];
    idVoucher = json['idVoucher'];
    note = json['note'];
    dateCreated = json['dateCreated'];
    dateCompleted = json['dateCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idOrder'] = this.idOrder;
    data['idUser'] = this.idUser;
    data['idAddress'] = this.idAddress;
    data['total'] = this.total;
    data['state'] = this.state;
    data['idVoucher'] = this.idVoucher;
    data['note'] = this.note;
    data['dateCreated'] = this.dateCreated;
    data['dateCompleted'] = this.dateCompleted;

    return data;
  }
}