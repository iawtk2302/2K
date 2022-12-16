import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sneaker_app/model/product_cart.dart';
import 'package:sneaker_app/router/routes.dart';
import 'package:sneaker_app/screen/bottomsheet_enter_pin.dart';
import 'package:sneaker_app/themes/ThemeService.dart';
import 'package:sneaker_app/widget/ItemAddress.dart';
import 'package:sneaker_app/widget/Loading.dart';
import 'package:sneaker_app/widget/OrderItem.dart';
import 'package:sneaker_app/widget/custom_button.dart';

import '../bloc/order/order_bloc.dart';
import '../model/voucher.dart';

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key, required this.listProduct});
  final List<ProductCart> listProduct;
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void initState() {
    BlocProvider.of<OrderBloc>(context).add(LoadOrder());
    super.initState();
  }

  final LocalAuthentication auth = LocalAuthentication();

  final _note = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.chevron_left,
            )),
        title: Text(
          "Checkout",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Loading();
          } else if (state is OrderLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "Shipping Address",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      state.listAddress.length > 0
                          ? ItemAddress(
                              address: state.selectedAddress!,
                              icon: IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, Routes.chooseAddress);
                                },
                                icon: Icon(Icons.edit),
                              ),
                            )
                          : AddNewAddress(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Container(
                          height: 1,
                          color: Color(0xFFECECEC),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          "Order List",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.listProduct.length,
                        itemBuilder: (context, index) =>
                            OrderItem(product: state.listProduct[index]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Container(
                          height: 1,
                          color: Color(0xFFECECEC),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          "Promo",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      state.selectedVoucher != null
                          ? _ItemShowVoucher(state.selectedVoucher!)
                          : AddNewVoucher(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Container(
                          height: 1,
                          color: Color(0xFFECECEC),
                        ),
                      ),
                      Text(
                        "Note",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Container(
                          height: 60,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: TextField(
                                controller: _note,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter Note',
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9F9E9E), fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: Column(children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Amount',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(state.totalProduct.toStringAsFixed(2))
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Shipping',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(state.priceShipping.toStringAsFixed(2))
                                ],
                              ),
                            ),
                            state.priceVoucher > 0
                                ? Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Promo',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text("-" +
                                            state.priceVoucher
                                                .toStringAsFixed(2))
                                      ],
                                    ),
                                  )
                                : Container(),
                            Divider(),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(state.total.toStringAsFixed(2))
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Center(
                          child: CustomElevatedButton(
                            text: "Payment",
                            onTap: () {
                              // print('object');

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
                                    // BlocProvider.of<OrderBloc>(context)
                                    //     .add(CreateOrder(_note.text, context));
                                  } else {
                                    debugPrint('check fail');
                                  }
                                }
                              });
                            },
                            colorText: ThemeService().theme == ThemeMode.dark
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    ]),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget AddNewAddress() {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.addAddress);
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color(0xFFE3E3E3)),
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color(0xFF161616)),
                            child: Container(
                              child: Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text("Add New Address",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18))
                    ],
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 32,
                  )
                ]),
          ),
        ));
  }

  Widget AddNewVoucher() {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.chooseVoucher);
        },
        child: Container(
          height: 70,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.confirmation_number),
                      SizedBox(width: 10),
                      Text("Choose voucher",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16))
                    ],
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 32,
                  )
                ]),
          ),
        ));
  }

  Widget _ItemShowVoucher(Voucher voucher) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            voucher.name.toString(),
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          IconButton(
              onPressed: () {
                BlocProvider.of<OrderBloc>(context).add(RemoveVoucher());
              },
              icon: Icon(Icons.close, color: Colors.white))
        ]),
      ),
    );
  }
}
