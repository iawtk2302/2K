import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sneaker_app/screen/AddAddress.dart';

import '../bloc/payment/payment.dart';

class PageTestSecond extends StatefulWidget {
  final String title;

  PageTestSecond(this.title);

  @override
  _PageTestSecondState createState() => _PageTestSecondState();
}

class _PageTestSecondState extends State<PageTestSecond> {
  static const EventChannel eventChannel = EventChannel('flutter.native/eventPayOrder');
  static const MethodChannel platform = MethodChannel('flutter.native/channelPayOrder');
  final textStyle = TextStyle(color: Colors.black54);
  final valueStyle = TextStyle(
      color: Colors.red, fontSize: 18.0, fontWeight: FontWeight.w400);
  String zpTransToken = "";
  String payResult = "";
  String payAmount = "10000";
  bool showResult = false;
  @override
  void initState() {
    super.initState();
    // if (Platform.isIOS) {
    //   eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
    // }
  }

  // void _onEvent(Object event) {
  //   print("_onEvent: '$event'.");
  //   var res = Map<String, dynamic>.from(event);
  //   setState(() {
  //     if (res["errorCode"] == 1) {
  //       payResult = "Thanh toán thành công";
  //     } else if  (res["errorCode"] == 4) {
  //       payResult = "User hủy thanh toán";
  //     }else {
  //       payResult = "Giao dịch thất bại";
  //     }
  //   });
  // }

  // void _onError(Object error) {
  //   print("_onError: '$error'.");
  //   setState(() {
  //     payResult = "Giao dịch thất bại";
  //   });
  // }

  // Button Create Order
  Widget _btnCreateOrder(String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: GestureDetector(
          onTap: () async {
            int amount = int.parse(value);
            if (amount < 1000 || amount > 1000000) {
              setState(() {
                zpTransToken = "Invalid Amount";
              });
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  });
              var result = await createOrderZaloPay(amount);
              if (result != null) {
                Navigator.pop(context);
                zpTransToken = result.zptranstoken;
                setState(() {
                  zpTransToken = result.zptranstoken;
                  showResult = true;
                });
              }
            }
          },
          child: Container(
              height: 50.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text("Create Order",
                  style: TextStyle(color: Colors.white, fontSize: 20.0))),
        ),
      );

  /// Build Button Pay
  Widget _btnPay(String zpToken) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Visibility(
        visible: showResult,
        child: GestureDetector(
          onTap: () async {
            String response = "";
            try {
              final String result = await platform.invokeMethod('payOrder', {"zptoken": zpToken});
              response = result;
              print("payOrder Result: '$result'.");
            } on PlatformException catch (e) {
              print("Failed to Invoke: '${e.message}'.");
              response = "Thanh toán thất bại";
            }
            print(response);
            setState(() {
              payResult = response;
            });
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddAddressPage(),));
          },
          child: Container(
              height: 50.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text("Pay",
                  style: TextStyle(color: Colors.white, fontSize: 20.0))),
        ),
      ));

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _quickConfig,
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Amount',
              icon: Icon(Icons.attach_money),
            ),
            initialValue: payAmount,
            onChanged: (value) {
              setState(() {
                payAmount = value;
              });
            },
            keyboardType: TextInputType.number,
          ),
          _btnCreateOrder(payAmount),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Visibility(
              child: Text(
                "zptranstoken:",
                style: textStyle,
              ),
              visible: showResult,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              zpTransToken,
              style: valueStyle,
            ),
          ),
          _btnPay(zpTransToken),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Visibility(
                child: Text("Transaction status:", style: textStyle),
                visible: showResult),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              payResult,
              style: valueStyle,
            ),
          ),
        ],
      ),
    );
  }
}

/// Build Info App
Widget _quickConfig = Container(
  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text("AppID: 2554"),
          ),
        ],
      ),
      // _btnQuickEdit,
    ],
  ),
);
