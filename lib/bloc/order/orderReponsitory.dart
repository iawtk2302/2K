import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sneaker_app/bloc/cart/card_bloc.dart';
import 'package:sneaker_app/bloc/payment/payment.dart';
import 'package:sneaker_app/model/order.dart';
import '../../model/address.dart';
import '../../model/product_cart.dart';
import '../../router/routes.dart';
import '../../widget/custom_button.dart';

class OrderReponsitory{
  final order = FirebaseFirestore.instance.collection('Order');
  final detailOrder = FirebaseFirestore.instance.collection('DetailOrder');
  static const MethodChannel platform = MethodChannel('flutter.native/channelPayOrder');
  caculateTotalProduct(List<ProductCart> listProduct){
    final totalProduct=listProduct.map((e) => e.product!.price!*e.amount!).reduce((value, element) => value+element).toDouble();
    return totalProduct;
  }
  clearProduct()async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('products');
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
  createOrder(List<ProductCart> list,String idVoucher, double totalPrice, String note, String idAddress, String methodPayment,BuildContext context)async{
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
    if(methodPayment=="ZaloPay"){
      Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);
      BlocProvider.of<CartBloc>(context).add(LoadCart());
      clearProduct(); 
      String zpTransToken="";
      var result = await createOrderZaloPay(totalPrice.toInt());
               if (result != null) {
                zpTransToken = result.zptranstoken;
                String response = "";
            try {
              final String result = await platform.invokeMethod('payOrder', {"zptoken": zpTransToken});
              response = result;
                          
            } on PlatformException catch (e) {         
              response = "Thanh toán thất bại";
            }
            print(response);
    //          Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);
    // BlocProvider.of<CartBloc>(context).add(LoadCart());
    // clearProduct();
    }
    }
    // Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);
    // BlocProvider.of<CartBloc>(context).add(LoadCart());
    // clearProduct();
  }
  void showSuccessDialog(BuildContext context){
  showDialog(context: context, 
  barrierDismissible: false,
  builder: (context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Image.asset("assets/images/order_success.png"),
        ),
        const Text("Order Successful!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
        const SizedBox(height: 15,),
        const Text("You have successfully made order",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
        const SizedBox(height: 30,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomElevatedButton(onTap: () { 
            BlocProvider.of<CartBloc>(context).add(LoadCart());
            Navigator.of(context)..pop()..pop(); 
            }, text: 'Back',color: Colors.black,),
        ),
        const SizedBox(height: 30,)
      ],),
    );
  },);
}

void showErrorDialog(BuildContext context){
  showDialog(context: context, 
  barrierDismissible: false,
  builder: (context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Image.asset("assets/images/order_error.png"),
        ),
        const Text("Order Error!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
        const SizedBox(height: 15,),
        const Text("Something went wrong.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
        const Text("Please, try again.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
        const SizedBox(height: 30,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomElevatedButton(onTap: () {  }, text: 'Try Again',color: Colors.black,),
        ),
        const SizedBox(height: 30,)
      ],),
    );
  },);
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