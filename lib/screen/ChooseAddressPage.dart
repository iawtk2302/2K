import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sneaker_app/bloc/address/address_bloc.dart';
import 'package:sneaker_app/bloc/order/order_bloc.dart';
import 'package:sneaker_app/widget/CustomAppBar.dart';
import 'package:sneaker_app/widget/ItemAddress.dart';
import 'package:sneaker_app/widget/Loading.dart';
import 'package:sneaker_app/widget/custom_button.dart';

import '../model/address.dart';
import '../router/routes.dart';

class ChooseAddressPage extends StatefulWidget {
  const ChooseAddressPage({super.key});

  @override
  State<ChooseAddressPage> createState() => _ChooseAddressPageState();
}

class _ChooseAddressPageState extends State<ChooseAddressPage> {
  Address? address;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFBFBFB),
      appBar: CustomAppBar(
        title: "Shipping Address",
        onTap: () {
          // BlocProvider.of<OrderBloc>(context).add(ChooseAddress(address!));
          Navigator.pop(context);
        },
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (BuildContext context, state) {
          if (state is OrderLoading) {
            return Loading();
          } else if (state is OrderLoaded) {
            address = state.selectedAddress;
            return SingleChildScrollView(
              child: Container(
                color: Color(0xFFFBFBFB),
                child: Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.listAddress.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ItemAddress(
                              address: state.listAddress[index],
                              icon: IconButton(
                                icon: state.listAddress[index] ==
                                        state.tempAddress
                                    ? const Icon(Icons.radio_button_checked)
                                    : Icon(Icons.radio_button_unchecked),
                                onPressed: () {
                                  BlocProvider.of<OrderBloc>(context).add(
                                      ChooseAddress(state.listAddress[index]));
                                },
                              ),
                            ),
                          );
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: CustomElevatedButton(
                        text: "Add New Address",
                        onTap: () {
                          Navigator.pushNamed(context, Routes.addAddress);
                        },
                        color: Color(0xFFE6E6E6),
                        colorText: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: CustomElevatedButton(
                        text: "Apply",
                        onTap: () async {
                          BlocProvider.of<OrderBloc>(context)
                              .add(ApplyAddress());
                        },
                        color: Colors.black,
                        colorText: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
