import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sneaker_app/model/order.dart';
import '../../model/address.dart';
import '../../model/product_cart.dart';

class OrderReponsitory{
  final order = FirebaseFirestore.instance.collection('Order');
  final detailOrder = FirebaseFirestore.instance.collection('DetailOrder');
  caculateTotalProduct(List<ProductCart> listProduct){
    final totalProduct=listProduct.map((e) => e.product!.price).reduce((value, element) => value!+element!)!.toDouble();
    return totalProduct;
  }
  getProduct()async{
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
    return products;
  }
  }
  caculateShipping(Address address, TypeShipping typeShipping)async{
    final uri = Uri.parse('https://dev-online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee');
    final headers = {
    'Content-Type': 'application/json',
    'Token':'73c52a61-51e5-11ed-9ad7-269dd9db11fd',
    'ShopId':'120064'
    };
    Map<String, dynamic> body = {
    "from_district_id":1463,
    "service_id":typeShipping.serviceId,
    "service_type_id":null,
    "to_district_id":address.districtID,
    "to_ward_code":address.wardCode,
    "height":50,
    "length":20,
    "weight":200,
    "width":20,
    "insurance_value":10000,
    "coupon": null
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    final response = await http.post(uri,headers: headers,body:jsonBody,encoding: encoding);
    final data= jsonDecode(response.body);
    return (data['data']['total']).toDouble();
  }
  getTypeShipping(Address address)async{
    final uri = Uri.parse('https://dev-online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/available-services');
    final headers = {
    'Content-Type': 'application/json',
    'Token':'73c52a61-51e5-11ed-9ad7-269dd9db11fd',
    };
    Map<String, dynamic> body = {
        'shop_id':120064,
        "from_district": 1463,
	      "to_district": address.districtID
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    final response = await http.post(uri,headers: headers,body:jsonBody,encoding: encoding);
    final data= jsonDecode(response.body);
    List<TypeShipping> listTypeShipping=[];
    data['data'].forEach((e){
      listTypeShipping.add(TypeShipping.fromJson(e));
    });
    
    return listTypeShipping;
  }
  createOrder(List<ProductCart> list,String idVoucher, double totalPrice, String note, String idAddress)async{
    String? idOrder;
    await order.add({'idUser':FirebaseAuth.instance.currentUser!.uid,
    'idAddress':idAddress,
    'idVoucher':idVoucher,
    'state':'packing','note':note,
    'dateCreated':DateTime.now(),
    'dateCompleted':DateTime.now(),
    'dateCanceled':DateTime.now(),
    'total':totalPrice}).then((value) {
      idOrder=value.id;
      order.doc(value.id).update({'idOrder':value.id});
    });
    for(ProductCart i in list){
      detailOrder.add({'idOrder':idOrder,'idProduct':i.product!.idProduct,'amount':i.amount,'size':i.size,}).then((value) {detailOrder.doc(value.id).update({'idDetailOrder':value.id});});
    }
  }
}

class TypeShipping {
  int? serviceId;
  String? shortName;
  int? serviceTypeId;
  TypeShipping({this.serviceId, this.shortName, this.serviceTypeId});

  TypeShipping.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    shortName = json['short_name'];
    serviceTypeId = json['service_type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.serviceId;
    data['short_name'] = this.shortName;
    data['service_type_id'] = this.serviceTypeId;
    return data;
  }
  CalculateTheExpectedDeliveryTime(Address address)async{
    final uri = Uri.parse('https://dev-online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/leadtime');
    final headers = {
    'Content-Type': 'application/json',
    'Token':'73c52a61-51e5-11ed-9ad7-269dd9db11fd',
    'ShopId':'120064'
    };
    Map<String, dynamic> body = {
        "from_district_id": 1463,
        "from_ward_code": "21808",
        "to_district_id": address.districtID,
        "to_ward_code": address.wardCode,
        "service_id": this.serviceId
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    final response = await http.post(uri,headers: headers,body:jsonBody,encoding: encoding);
    final data= jsonDecode(response.body);
    return data['data'];
  } 
}