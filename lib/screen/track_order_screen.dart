import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sneaker_app/bloc/my_order/my_order_bloc.dart';
import 'package:sneaker_app/model/detail_order.dart';
import 'package:sneaker_app/model/order.dart';
import 'package:sneaker_app/model/product.dart';
import 'package:sneaker_app/model/product_cart.dart';
import 'package:sneaker_app/widget/Loading.dart';
import 'package:sneaker_app/widget/custom_textbutton.dart';
import 'package:sneaker_app/widget/item_product_trackorder.dart';

import '../bloc/list_order/list_order_bloc.dart';
import '../router/routes.dart';
import '../widget/delivery_address.dart';
import '../widget/order_state.dart';
import '../widget/tracking_order.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({super.key, required this.order});
  final MyOrder order;
  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  List<Product> listProduct = [];
  List<ProductCart> listProductCart = [];
  final List<DetailOrder> listDetailOrder = [];
  late int statusNum;
  final List<IconData> listIcon = [
    FontAwesomeIcons.box,
    FontAwesomeIcons.truck,
    FontAwesomeIcons.peopleCarryBox,
    FontAwesomeIcons.boxOpen,
  ];

  @override
  void initState() {
    // getDetailProduct();
    solveStatus();
    BlocProvider.of<ListOrderBloc>(context)
        .add(LoadListOrder(order: widget.order));
    super.initState();
  }

  // getDetailProduct() async {
  //   final docDetailOrder = FirebaseFirestore.instance.collection('DetailOrder');
  // }
  String convertPrice(double price) {
    final format = NumberFormat("###,###.###", "tr_TR");

    return format.format(price) + 'đ';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              // color: Colors.black,
            ),
          ),
          title: Text(
            'Track Order'.tr,
            style: const TextStyle(
                // color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Urbanist'),
          ),
        ),
        body: BlocBuilder<ListOrderBloc, ListOrderState>(
          builder: (context, state) {
            if (state is ListOrderLoading) {
              return Loading();
            } else if (state is ListOrderLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(children: [
                    const SizedBox(
                      height: 16,
                    ),
                    OrderState(order: widget.order, statusNum: statusNum),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height:
                          (155 * state.listProduct.length.toInt()).toDouble(),
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.listProduct.length,
                          itemBuilder: ((context, index) {
                            // print(state.listProduct.length);z
                            return Item_Product_TrackOrder(
                              order: widget.order,
                              product: state.listProduct[index],
                              isInModal: false,
                            );
                          })),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total price: '.tr,
                          style: TextStyle(
                              // color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              fontFamily: 'Urbanist'),
                        ),
                        Text(
                          convertPrice(widget.order.total!) + 'đ',
                          style: TextStyle(
                              // color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              fontFamily: 'Urbanist'),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Order status detail'.tr,
                        style: const TextStyle(
                            // color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                            fontFamily: 'Urbanist'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Track_delivery(),
                    // const SizedBox(
                    //   height: 40,
                    // ),
                    DeliveryAddress(order: widget.order),
                    const SizedBox(
                      height: 16,
                    ),
                    OrderTracking(
                      order: widget.order,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 22),
                      child: CustomTextButton(
                          onPressed: () {
                            List<ProductCart> tempList = state.listProduct;
                            solvePrimaryButton(state.listProduct);
                          },
                          text: getText().tr,
                          hasLeftIcon: false,
                          isDark: true,
                          hasRightIcon: false),
                    )
                  ]),
                ),
              );
            } else
              return Container();
          },
        ));
  }

  solveStatus() {
    switch (widget.order.state) {
      case 'packing':
        {
          statusNum = 0;
          break;
        }
      case 'delivery':
        {
          statusNum = 1;
          break;
        }
      case 'delivered':
        {
          statusNum = 2;
          break;
        }
      case 'completed':
        {
          statusNum = 3;
          break;
        }
      case 'canceled':
        {
          statusNum = 4;
          break;
        }
    }
  }

  String getText() {
    switch (statusNum) {
      case 3:
      case 4:
        return 'Re-Order';
      case 0:
        return 'Cancel';
      default:
        return 'Contact';
    }
  }

  void solvePrimaryButton(List<ProductCart> state) {
    switch (widget.order.state) {
      case 'completed':
      case 'canceled':
        print(state);
        Navigator.pushNamed(context, Routes.checkout, arguments: state);
        break;
      case 'packing':
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Confirm'),
            content: const Text('Do you want to cancel this order'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read<MyOrderBloc>().add(UpdateStateMyOrder(
                      order: widget.order, state: 'canceled'));
                  setState(() {
                    statusNum = 4;
                  });
                  Navigator.pop(context, 'Yes');
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
        break;
      default:
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text(
              'This is show dialog contact',
            ),
            content: const Text('AlertDialog description'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(
                        TextStyle(color: Colors.black))),
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
    }
  }
}
