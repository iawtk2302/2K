
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sneaker_app/bloc/order/order_bloc.dart';
import 'package:sneaker_app/model/address.dart';
import 'package:http/http.dart' as http;
class AddressReponsitory{
  final addresses = FirebaseFirestore.instance.collection('Address');
  chooseAddress(Address address)async{
    await addresses
      .where('idUser',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where('isDefault',isEqualTo: true).get().then((value){
        value.docs.forEach((element) { 
          addresses.doc(element.id).update({'isDefault':false});
        });
      });
      await addresses.doc(address.idAddress).update({"isDefault":true});
  }
  getDataAddress()async{
    final List<Address> listAddress=[];
    await addresses.orderBy('isDefault',descending: true).where('idUser',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .get().then((value) {
      listAddress.addAll(value.docs.map((e) => Address.fromJson(e.data())).toList());
    });
    return listAddress;
  }
  getAddressDefault()async{
    Address? address;
    await addresses.where('idUser',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .where('isDefault',isEqualTo: true)
    .get().then((value) {
      if(value.docs.isNotEmpty){
        address=Address.fromJson(value.docs.first.data());
      }
    });
    return address;
  }
  getProvince()async{
    final uri = Uri.parse('https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/province');
    final response = await http.post(uri,headers: {'Token':'73c52a61-51e5-11ed-9ad7-269dd9db11fd'});
    final data= jsonDecode(response.body);
    List<Province> listProvince=[];
    data['data'].forEach((e){
      Province temp=Province.fromJson(e);
      listProvince.add(temp);
    });
    return listProvince;
  }
  getDistrict(int provinceID)async{
  final uri = Uri.parse('https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/district');
  final headers = {'Content-Type': 'application/json','Token':'73c52a61-51e5-11ed-9ad7-269dd9db11fd'};
  Map<String, dynamic> body = {'province_id': provinceID};
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');
    final response = await http.post(uri,headers: headers,body:jsonBody,encoding: encoding);
    final data= jsonDecode(response.body);
    List<District> listDistrict=[];
    data['data'].forEach((e){
      District temp=District.fromJson(e);
      listDistrict.add(temp);
    });
    return listDistrict;
  }
  getWard(int districtID)async{
  final uri = Uri.parse('https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/ward?district_id');
  final headers = {'Content-Type': 'application/json','Token':'73c52a61-51e5-11ed-9ad7-269dd9db11fd'};
  Map<String, dynamic> body = {'district_id': districtID};
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');
    final response = await http.post(uri,headers: headers,body:jsonBody,encoding: encoding);
    final data= jsonDecode(response.body);
    List<Ward> listWard=[];
    data['data'].forEach((e){
      Ward temp=Ward.fromJson(e);
      listWard.add(temp);
    });
    return listWard;
  }
  addAddress(Address address)async{
    if(address.isDefault!){
      await addresses
      .where('idUser',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where('isDefault',isEqualTo: true).get().then((value){
        value.docs.forEach((element) { 
          addresses.doc(element.id).update({'isDefault':false});
        });
      });
      await addresses.add(address.toJson()).then((value) => addresses.doc(value.id).update({'idAddress':value.id}));
    }
    else{
      await addresses.add(address.toJson()).then((value) => addresses.doc(value.id).update({'idAddress':value.id}));
    }  
  }
  checkHaveAddress()async{
    bool? isCheck;
      await addresses
      .where('idUser',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get().then((value) {
        if(value.docs.isEmpty){
          isCheck=false;
        }
        else{
          isCheck=true;
        }
      }); 
      return isCheck;
  }
}

String removeDiacritics(String str) {

  var withDia = 'àáãảạăằắẳẵặâầấẩẫậèéẻẽẹêềếểễệđùúủũụưừứửữựòóỏõọôồốổỗộơờớởỡợìíỉĩịäëïîöüûñçýỳỹỵỷĐ';
  var withoutDia = 'aaaaaaaaaaaaaaaaaeeeeeeeeeeeduuuuuuuuuuuoooooooooooooooooiiiiiaeiiouuncyyyyyD'; 

  for (int i = 0; i < withDia.length; i++) {      
    str = str.replaceAll(withDia[i], withoutDia[i]);
  }
  return str;
}

class Province {
  int? provinceID;
  String? provinceName;

  Province({this.provinceID, this.provinceName});

  Province.fromJson(Map<String, dynamic> json) {
    provinceID = json['ProvinceID'];
    provinceName = removeDiacritics(json['ProvinceName']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProvinceID'] = this.provinceID;
    data['ProvinceName'] = this.provinceName;
    return data;
  }
}
class District {
  int? districtID;
  String? districtName;

  District({this.districtID, this.districtName});

  District.fromJson(Map<String, dynamic> json) {
    districtID = json['DistrictID'];
    districtName = removeDiacritics(json['DistrictName']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DistrictID'] = this.districtID;
    data['DistrictName'] = this.districtName;
    return data;
  }
}
class Ward {
  String? wardName;
  String? wardCode;

  Ward({this.wardName});

  Ward.fromJson(Map<String, dynamic> json) {
    wardName = removeDiacritics(json['WardName']);
    wardCode = removeDiacritics(json['WardCode']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['WardName'] = this.wardName;
    data['WardCode'] = this.wardCode;
    return data;
  }
}