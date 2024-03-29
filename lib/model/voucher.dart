import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Voucher extends Equatable {
  String? idVoucher;
  String? name;
  Timestamp? dateStart;
  Timestamp? dateEnd;
  String? content;
  double? percent;
  double? amount;
  double? maximum;
  Voucher(
      {this.idVoucher,
      this.name,
      this.dateStart,
      this.dateEnd,
      this.content,
      this.percent,
      this.amount,
      this.maximum});

  Voucher.fromJson(Map<String, dynamic> json) {
    idVoucher = json['idVoucher'];
    name = json['name'];
    dateStart = json['dateStart'];
    dateEnd = json['dateEnd'];
    content = json['content'];
    percent = double.tryParse(json['percent'].toString());
    amount = double.tryParse(json['amount'].toString());
    maximum = double.tryParse(json['maximum'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idVoucher'] = this.idVoucher;
    data['name'] = this.name;
    data['dateStart'] = this.dateStart;
    data['dateEnd'] = this.dateEnd;
    data['content'] = this.content;
    data['percent'] = this.percent;
    data['amount'] = this.content;
    data['maximum'] = this.percent;
    return data;
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [idVoucher,dateStart,dateEnd,content,percent,amount,maximum];
}