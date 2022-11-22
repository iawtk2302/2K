import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../model/voucher.dart';

class VoucherRepository{
  final vouchers=FirebaseFirestore.instance.collection('Voucher');
  getVoucher()async{
    final now = Timestamp.fromDate(DateTime.now());
    List<Voucher> temp=[];
    List<Voucher> temp1=[];
    List<Voucher> temp2=[];
    await vouchers.where("dateStart",isLessThanOrEqualTo: now)
    .get()
    .then((value) {
      value.docs.forEach((element) {
        temp1.add(Voucher.fromJson(element.data()));
       });
    });
    await vouchers.where("dateEnd",isGreaterThanOrEqualTo: now)
    .get()
    .then((value) {
      value.docs.forEach((element) {
        temp2.add(Voucher.fromJson(element.data()));
       });
    });
    temp1.forEach((element) {
      if(temp2.contains(element)){
        temp.add(element);
      }
     });
    return temp;
  }
}