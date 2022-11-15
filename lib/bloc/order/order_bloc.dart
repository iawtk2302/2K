import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sneaker_app/bloc/address/addressReponsitory.dart';
import 'package:sneaker_app/bloc/order/orderReponsitory.dart';
import 'package:sneaker_app/model/product_cart.dart';

import '../../model/address.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<LoadOrder>((event, emit) async {
      emit(OrderLoading());
      // final shipping=await OrderReponsitory().caculateShipping(selectedAddress);
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
      emit(OrderLoaded(selectedAddress,selectedAddress,listAddress,totalProduct,shipping,total,listProduct,listTypeShipping));
    });
    on<ChooseAddress>((event, emit) async{
      final state=this.state as OrderLoaded;
      Address selectedAddress=state.selectedAddress!;
      Address tempAddress=event.newAddress;
      final totalProduct=state.totalProduct;
      List<Address> listAddress=state.listAddress;
      List<ProductCart> listProduct=state.listProduct;
      List<TypeShipping> listTypeShipping=state.listTypeShipping!;
      final shipping=state.priceShipping;
      emit(OrderLoaded(selectedAddress,tempAddress,listAddress,totalProduct,shipping,0,listProduct,listTypeShipping));
    });
    on<ApplyAddress>((event, emit) async{
      final state=this.state as OrderLoaded;
      Address selectedAddress=state.tempAddress!;
      Address tempAddress=state.tempAddress!;
      final totalProduct=state.totalProduct;
      List<Address> listAddress=state.listAddress;
      List<ProductCart> listProduct=state.listProduct;
      List<TypeShipping> listTypeShipping=await OrderReponsitory().getTypeShipping(selectedAddress);
      final shipping=await OrderReponsitory().caculateShipping(selectedAddress,listTypeShipping[0])/10000;
      final total=shipping+totalProduct;
      emit(OrderLoaded(selectedAddress,tempAddress,listAddress,totalProduct,shipping,total,listProduct,listTypeShipping));
    });
    on<CreateOrder>((event, emit) async {
      final state=this.state as OrderLoaded;
      await OrderReponsitory().createOrder(state.listProduct, "idVoucher", state.total, "Coi chung be",state.selectedAddress!.idAddress!.toString());
    });
  }
}
