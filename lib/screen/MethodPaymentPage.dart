import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sneaker_app/screen/PageTest.dart';
import 'package:sneaker_app/widget/Loading.dart';

import '../bloc/cart/card_bloc.dart';
import '../bloc/order/orderReponsitory.dart';
import '../bloc/order/order_bloc.dart';
import '../bloc/payment/payment.dart';
import '../model/address.dart';
import '../model/product_cart.dart';
import '../model/voucher.dart';
import '../router/routes.dart';
import '../themes/ThemeService.dart';
import '../widget/CustomAppBar.dart';
import '../widget/custom_button.dart';
import 'PageTestSecond.dart';
import 'bottomsheet_enter_pin.dart';

class MethodPaymentPage extends StatefulWidget {
  const MethodPaymentPage({super.key, required this.note});
  final String note;
  @override
  State<MethodPaymentPage> createState() => _MethodPaymentPageState();
}

class _MethodPaymentPageState extends State<MethodPaymentPage> {
  int currentIndex = -1;
  static const MethodChannel platform = MethodChannel('flutter.native/channelPayOrder');
  final order = FirebaseFirestore.instance.collection('Order');
  final detailOrder = FirebaseFirestore.instance.collection('DetailOrder');
  final vouchers = FirebaseFirestore.instance.collection('Voucher');
  String payResult = "";
  // static const EventChannel eventChannel = EventChannel('flutter.native/channelPayOrder');

  // void _onEvent(Object? event) {
  //   // var res = event.data() as Map<String, dynamic>;
  //   // if (res["errorCode"] == 1) {

  //   //   } else if  (res["errorCode"] == 4) {

  //   //   }else {

  //   //   }
  //   Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);
  //   BlocProvider.of<CartBloc>(context).add(LoadCart());
  //   OrderReponsitory().clearProduct();
  // }

  // void _onError(Object error) {
  //   print("_onError: '$error'.");

  // }
  // @override
  // void initState() {
  //   eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
  //   super.initState();
  // }
  createOrder(List<ProductCart> list,Voucher? voucher, double totalPrice, String note, Address address, String methodPayment,BuildContext context)async{
    String? idOrder;
    await order.add({'idUser':FirebaseAuth.instance.currentUser!.uid,
    'idAddress':address.idAddress,
    'idVoucher':voucher==null?"":voucher.idVoucher,
    'state':'packing','note':note,
    'dateCreated':DateTime.now(),
    'dateCompleted':DateTime.now(),
    'dateCanceled':DateTime.now(),
    'detailAddress':"${address.detail}, ${address.ward}, ${address.district}, ${address.province}",
    'total':totalPrice}).then((value) {
      idOrder=value.id;
      order.doc(value.id).update({'idOrder':value.id});
    });
    for(ProductCart i in list){
      detailOrder.add({'idOrder':idOrder,'idProduct':i.product!.idProduct,'amount':i.amount,'size':i.size,}).then((value) {detailOrder.doc(value.id).update({'idDetailOrder':value.id});});
    }
    if(voucher!=null){
      Voucher? tempVoucher;
    await vouchers.doc(voucher!.idVoucher!).get().then((value) => tempVoucher=Voucher.fromJson(value.data()!));
    if(voucher.idVoucher!=""){
      await vouchers.doc(voucher.idVoucher).update({"amount":tempVoucher!.amount!-1});
    }
    }
    if(methodPayment=="ZaloPay"){
      // Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);
      // BlocProvider.of<CartBloc>(context).add(LoadCart());
      // clearProduct(); 
      String zpTransToken="";
      var result = await createOrderZaloPay(totalPrice.toInt());
      String response = "";
               if (result != null) {
                zpTransToken = result.zptranstoken;
                
            
            // Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);
            // Navigator.push(context, MaterialPageRoute(builder: (context) => PageTest(),));
    // BlocProvider.of<CartBloc>(context).add(LoadCart());
    // clearProduct();
    }
    // setState(() {
    //           payResult=response;
    //         });
            try {
              final String result = await platform.invokeMethod('payOrder', {"zptoken": zpTransToken});
              response = result;
              print("payOrder Result: '$result'.");            
            } on PlatformException catch (e) { 
              print("Failed to Invoke: '${e.message}'.");        
              response = "Thanh toán thất bại";
            }
            print(response);
            setState(() {
              payResult=response;
            });
            if(response=="Payment Success"){
              // Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);
              BlocProvider.of<CartBloc>(context).add(LoadCart());
              OrderReponsitory().clearProduct();
              Navigator.pushNamed(context, Routes.success);
            }
            else if(response=="User Canceled"){
              Navigator.pushNamed(context, Routes.failed);
            }
            else if(response=="Payment failed"){
              Navigator.pushNamed(context, Routes.failed);
            }
            // Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);
    }
    else{
      BlocProvider.of<CartBloc>(context).add(LoadCart());
      OrderReponsitory().clearProduct();
      Navigator.pushNamed(context, Routes.success);
    }
    // Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);
    // BlocProvider.of<CartBloc>(context).add(LoadCart());
    // clearProduct();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "Payment Methods".tr,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderSuccess) {              
            Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);
            BlocProvider.of<CartBloc>(context).add(LoadCart());
            OrderReponsitory().clearProduct(); 
        }   
        },
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderLoading) {
              return Loading();
            } else if (state is OrderLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text("Select the payment method you want to use.".tr),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            currentIndex = 0;
                          });
                        },
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/cash.png",
                                      height: 50,
                                      width: 50,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Cash".tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                currentIndex == 0
                                    ? Icon(Icons.radio_button_checked)
                                    : Icon(Icons.radio_button_unchecked)
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            currentIndex = 1;
                          });
                        },
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/ZaloPay-text.png",
                                      height: 50,
                                      width: 50,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("ZaloPay",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ))
                                  ],
                                ),
                                currentIndex == 1
                                    ? Icon(Icons.radio_button_checked)
                                    : Icon(Icons.radio_button_unchecked)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      CustomElevatedButton(
                        text: "Confirm Payment".tr,
                        onTap: () {
                          showModalBottomSheet<bool>(
                            isScrollControlled: true,
                            context: context,
                            useRootNavigator: true,
                            builder: (BuildContext context) {
                              return const BottomSheetEnterPin();
                            },
                          ).then((value) {
                            if (value != null) {
                              if (value) {
                                debugPrint('check successful');
                                // BlocProvider.of<OrderBloc>(context).add(
                                //     CreateOrder(
                                //         widget.note,
                                //         currentIndex == 0 ? "Cash" : "ZaloPay",
                                //         context));
                                createOrder(state.listProduct, state.selectedVoucher, state.total, widget.note, state.selectedAddress!, currentIndex == 0 ? "Cash" : "ZaloPay", context);
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => PageTestSecond('hihi'),));
                              } else {
                                debugPrint('check fail');
                              }
                            }
                          });

                          // Navigator.pushNamed(context, Routes.choosePayment);
                        },
                        colorText: ThemeService().theme == ThemeMode.dark
                            ? Colors.black
                            : Colors.white,
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ]),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
