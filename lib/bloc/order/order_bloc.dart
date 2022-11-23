

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:sneaker_app/bloc/address/addressReponsitory.dart';
import 'package:sneaker_app/bloc/order/orderReponsitory.dart';
import 'package:sneaker_app/bloc/order/voucherRepository.dart';
import 'package:sneaker_app/model/product_cart.dart';

import '../../model/address.dart';
import '../../model/voucher.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<LoadOrder>((event, emit) async {
      emit(OrderLoading());
      // final shipping=await OrderReponsitory().caculateShipping(selectedAddress);
      List<Voucher>listVoucher=await VoucherRepository().getVoucher();
      List<Address> listAddress=await AddressReponsitory().getDataAddress();
      Address? selectedAddress=await AddressReponsitory().getAddressDefault();
      List<ProductCart> listProduct=await OrderReponsitory().getProduct();
      // await OrderReponsitory().getTypeShipping(selectedAddress!);
      double shipping=0;
      List<TypeShipping> listTypeShipping=[];
      if(selectedAddress==null){
        shipping=0;
      }
      else{
        listTypeShipping=await OrderReponsitory().getTypeShipping(selectedAddress);
        shipping=await OrderReponsitory().caculateShipping(selectedAddress,listTypeShipping[0])/10000; 
      } 
      final totalProduct=OrderReponsitory().caculateTotalProduct(listProduct);
      final total=shipping+totalProduct;
      emit(OrderLoaded(selectedAddress,selectedAddress,listAddress,totalProduct,shipping,total,listProduct,listTypeShipping,null,null,listVoucher,0));
    });
    on<ChooseAddress>((event, emit) async{
      final state=this.state as OrderLoaded;
      emit(OrderLoading());
      Address selectedAddress=state.selectedAddress!;
      Address tempAddress=event.newAddress;
      final totalProduct=state.totalProduct;
      List<Address> listAddress=state.listAddress;
      List<ProductCart> listProduct=state.listProduct;
      List<TypeShipping> listTypeShipping=state.listTypeShipping!;
      final shipping=state.priceShipping;
      emit(OrderLoaded(selectedAddress,tempAddress,listAddress,totalProduct,shipping,0,listProduct,listTypeShipping,state.selectedVoucher,state.tempVoucher,state.listVoucher,state.priceVoucher));
    });
    on<ApplyAddress>((event, emit) async{
      final state=this.state as OrderLoaded;
      emit(OrderLoading());
      Address selectedAddress=state.tempAddress!;
      Address tempAddress=state.tempAddress!;
      final totalProduct=state.totalProduct;
      List<Address> listAddress=state.listAddress;
      List<ProductCart> listProduct=state.listProduct;
      List<TypeShipping> listTypeShipping=await OrderReponsitory().getTypeShipping(selectedAddress);
      final shipping=await OrderReponsitory().caculateShipping(selectedAddress,listTypeShipping[0])/10000;
      final total=shipping+totalProduct;
      emit(OrderLoaded(selectedAddress,tempAddress,listAddress,totalProduct,shipping,total,listProduct,listTypeShipping,state.selectedVoucher,state.tempVoucher,state.listVoucher,state.priceVoucher));
    });
    on<ChooseVoucher>((event, emit) async{
      final state=this.state as OrderLoaded;
      emit(OrderLoading());
      Voucher? selectedVoucher=state.selectedVoucher;
      Voucher? tempVoucher=event.newVoucher;
      final totalProduct=state.totalProduct;
      emit(OrderLoaded(state.selectedAddress,state.tempAddress,state.listAddress,totalProduct,state.priceShipping,state.total,state.listProduct,state.listTypeShipping,selectedVoucher,tempVoucher,state.listVoucher,state.priceVoucher));
    });
    on<ApplyVoucher>((event, emit) async{
      final state=this.state as OrderLoaded;
      emit(OrderLoading());
      Voucher? selectedVoucher=state.tempVoucher;
      Voucher? tempVoucher=state.tempVoucher;
      final totalProduct=state.totalProduct;
      final priceVoucher=state.totalProduct*selectedVoucher!.percent!;
      emit(OrderLoaded(state.selectedAddress,state.tempAddress,state.listAddress,totalProduct,state.priceShipping,state.total-priceVoucher,state.listProduct,state.listTypeShipping,selectedVoucher,tempVoucher,state.listVoucher,priceVoucher));
    });
    on<RemoveVoucher>((event, emit) async{
      final state=this.state as OrderLoaded;
      emit(OrderLoading());
      final totalProduct=state.totalProduct;
      emit(OrderLoaded(state.selectedAddress,state.tempAddress,state.listAddress,totalProduct,state.priceShipping,totalProduct+state.priceShipping,state.listProduct,state.listTypeShipping,null,null,state.listVoucher,0));
    });
    on<CreateOrder>((event, emit) async {
      final state=this.state as OrderLoaded;
      if(state.selectedAddress==null){
        OrderReponsitory().showErrorDialog(event.context);
      }
      else{
        await OrderReponsitory().createOrder(state.listProduct, state.selectedVoucher==null?"":state.selectedVoucher!.idVoucher!, state.total, event.note,state.selectedAddress!.idAddress!.toString());
        await OrderReponsitory().clearProduct();
        OrderReponsitory().showSuccessDialog(event.context);
      }
    });
  }
}
