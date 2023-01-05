import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sneaker_app/bloc/address/address_bloc.dart';
import 'package:sneaker_app/bloc/order/order_bloc.dart';
import 'package:sneaker_app/widget/CustomAppBar.dart';
import 'package:sneaker_app/widget/ItemAddress.dart';
import 'package:sneaker_app/widget/Loading.dart';
import 'package:sneaker_app/widget/custom_button.dart';
import 'package:sneaker_app/widget/item_voucher.dart';

import '../model/address.dart';
import '../model/voucher.dart';
import '../router/routes.dart';

class ChooseVoucherPage extends StatefulWidget {
  const ChooseVoucherPage({super.key});

  @override
  State<ChooseVoucherPage> createState() => _ChooseVoucherPageState();
}

class _ChooseVoucherPageState extends State<ChooseVoucherPage> {
  Voucher? voucher;
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(title: "Voucher".tr,onTap: (){
        BlocProvider.of<OrderBloc>(context).add(ChooseVoucher(null));
        Navigator.pop(context);
      },),
      body: BlocBuilder<OrderBloc,OrderState>(
        builder: (BuildContext context, state) { 
          if(state is OrderLoading){
            return Loading();
          }
          else if(state is OrderLoaded){
            if(state.tempVoucher==null){
              BlocProvider.of<OrderBloc>(context).add(ChooseVoucher(state.selectedVoucher));
            }
            if(state.listVoucher.length>0){
              return SingleChildScrollView(
              child: Container(
                // color: Color(0xFFFBFBFB),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.listVoucher.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ItemVoucher(voucher: state.listVoucher[index],
                          icon: IconButton(icon:state.listVoucher[index]==state.tempVoucher?const Icon(Icons.radio_button_checked):Icon(Icons.radio_button_unchecked), onPressed: () {  
                            BlocProvider.of<OrderBloc>(context).add(ChooseVoucher(state.listVoucher[index]));
                          },),),
                        );
                      }),
                     Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: CustomElevatedButton(text: "Apply".tr, 
                      onTap: (){
                        BlocProvider.of<OrderBloc>(context).add(ApplyVoucher());
                      }, 
                      color: Colors.black,
                      colorText: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            );
            }
            else{
              return NoVoucher();
            }
          }
          else{
            return Container();
          }
         },
        ),
    );
  }
}

Widget NoVoucher(){
  return Center(
    child: Column(
      children: [
      SizedBox(height: 180,),
      Icon(Icons.confirmation_number,size: 100,),
      Text("There are no voucher available",style: TextStyle(fontSize: 16),),
    ]),
  );
}
