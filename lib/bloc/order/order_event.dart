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

class ChooseVoucher extends OrderEvent {
  const ChooseVoucher(this.newVoucher);
  final Voucher? newVoucher;
  @override
  List<Object> get props => [newVoucher!];
}

class ApplyVoucher extends OrderEvent {
  const ApplyVoucher();
  @override
  List<Object> get props => [];
}

class RemoveVoucher extends OrderEvent {
  const RemoveVoucher();
  @override
  List<Object> get props => [];
}

class CreateOrder extends OrderEvent {
  const CreateOrder(this.note, this.context);
  final String note;
  final BuildContext context;
  @override
  List<Object> get props => [];
}


