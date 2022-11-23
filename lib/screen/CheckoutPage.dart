import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sneaker_app/model/product_cart.dart';
import 'package:sneaker_app/router/routes.dart';
import 'package:sneaker_app/widget/ItemAddress.dart';
import 'package:sneaker_app/widget/Loading.dart';
import 'package:sneaker_app/widget/OrderItem.dart';
import 'package:sneaker_app/widget/custom_button.dart';

import '../bloc/cart/card_bloc.dart';
import '../bloc/order/order_bloc.dart';
import '../widget/cart_item.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBFBFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.chevron_left,
              color: Colors.black,
            )),
        title: Text(
          "Checkout",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if(state is OrderLoading){
            return const Loading();
          }
          else if(state is OrderLoaded){
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
                    state.listAddress.length>0?ItemAddress(
                      address: state.selectedAddress!,
                      icon: IconButton(onPressed: () {
                        Navigator.pushNamed(context, Routes.chooseAddress);
                      }, icon: Icon(Icons.edit),
                      ),
                    ):AddNewAddress(),
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
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Container(
                        height: 1,
                        color: Color(0xFFECECEC),
                      ),
                    ),
                    Text(
                      "Promo Code",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 260,
                            height: 60,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter Promo Code',
                                    hintStyle: TextStyle(
                                      color: Color(0xFF9F9E9E),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xFFF9F9FA),
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.black),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                    ),
                    Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                          child: Column(children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Text('Amount',style: TextStyle(color: Color(0xFF605F5D), fontWeight: FontWeight.w600),),
                                Text(state.totalProduct.toStringAsFixed(2))
                              ],),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Text('Shipping',style: TextStyle(color: Color(0xFF605F5D), fontWeight: FontWeight.w600),),
                                Text(state.priceShipping.toStringAsFixed(2))
                              ],),
                            ),
                            Divider(),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Text('Total',style: TextStyle(color: Color(0xFF605F5D), fontWeight: FontWeight.w600),),
                                Text(state.total.toStringAsFixed(2))
                              ],),
                            ),
                          ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: CustomElevatedButton(text: "Payment", onTap: (){},color: Colors.black,),
                      )
                  ]),
            ),
          );
          }
          else{
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
}

