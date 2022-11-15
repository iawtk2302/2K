part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}
class LoadOrder extends OrderEvent {
  const LoadOrder();
  @override
  List<Object> get props => [];
}

class ChooseAddress extends OrderEvent {
  const ChooseAddress(this.newAddress);
  final Address newAddress;
  @override
  List<Object> get props => [];
}

class ApplyAddress extends OrderEvent {
  const ApplyAddress();
  @override
  List<Object> get props => [];
}

class CreateOrder extends OrderEvent {
  const CreateOrder();
  @override
  List<Object> get props => [];
}


