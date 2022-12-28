import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sneaker_app/widget/Loading.dart';

import '../bloc/cart/card_bloc.dart';
import '../bloc/order/orderReponsitory.dart';
import '../bloc/order/order_bloc.dart';
import '../themes/ThemeService.dart';
import '../widget/CustomAppBar.dart';
import '../widget/custom_button.dart';

class MethodPaymentPage extends StatefulWidget {
  const MethodPaymentPage({super.key, required this.note});
  final String note;
  @override
  State<MethodPaymentPage> createState() => _MethodPaymentPageState();
}

class _MethodPaymentPageState extends State<MethodPaymentPage> {
  int currentIndex = -1;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "Payment Methods",
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if(state is OrderLoading){
            return Loading();
          }
          else if(state is OrderLoaded){
            return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 10,
              ),
              Text("Select the payment method you want to use."),
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
                              "Cash",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
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
                text: "Confirm Payment",
                onTap: () {
                  BlocProvider.of<OrderBloc>(context).add(CreateOrder(widget.note,currentIndex==0?"Cash":"ZaloPay",context));
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
          }
          else{
            return Container();
          }
        },
      ),
    );
  }
}
