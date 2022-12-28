part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();
  
  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  const OrderLoaded(this.selectedAddress, this.tempAddress, this.listAddress, this.totalProduct, this.priceShipping, this.total, this.listProduct, this.listTypeShipping, this.selectedVoucher, this.tempVoucher, this.listVoucher, this.priceVoucher);
  final Address? selectedAddress;
  final Address? tempAddress;
  final List<Address> listAddress;
  final Voucher? selectedVoucher;
  final Voucher? tempVoucher;
  final List<Voucher> listVoucher;
  final List<ProductCart> listProduct;
  final double totalProduct;
  final double priceShipping;
  final double priceVoucher;
  final double total;
  final List<TypeShipping>? listTypeShipping;
  @override
  List<Object> get props => [selectedAddress!,tempAddress!,listAddress,tempAddress!,selectedVoucher!,tempVoucher!];
}

class OrderLoadedParameter extends OrderState {
  const OrderLoadedParameter(this.selectedAddress, this.tempAddress, this.listAddress, this.totalProduct, this.priceShipping, this.total, this.listProduct, this.listTypeShipping, this.selectedVoucher, this.tempVoucher, this.listVoucher, this.priceVoucher);
  final Address? selectedAddress;
  final Address? tempAddress;
  final List<Address> listAddress;
  final Voucher? selectedVoucher;
  final Voucher? tempVoucher;
  final List<Voucher> listVoucher;
  final List<ProductCart> listProduct;
  final double totalProduct;
  final double priceShipping;
  final double priceVoucher;
  final double total;
  final List<TypeShipping>? listTypeShipping;
  @override
  List<Object> get props => [selectedAddress!,tempAddress!,listAddress,tempAddress!,selectedVoucher!,tempVoucher!];
}
