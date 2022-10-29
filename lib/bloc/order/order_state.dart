part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();
  
  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  const OrderLoaded(this.selectedAddress, this.tempAddress, this.listAddress, this.totalProduct, this.priceShipping, this.total, this.listProduct, this.listTypeShipping);
  final Address? selectedAddress;
  final Address? tempAddress;
  final List<Address> listAddress;
  final List<ProductCart> listProduct;
  final double totalProduct;
  final double priceShipping;
  final double total;
  final List<TypeShipping>? listTypeShipping;
  @override
  List<Object> get props => [selectedAddress!,tempAddress!,listAddress];
}
