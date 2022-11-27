// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'my_order_bloc.dart';

abstract class MyOrderEvent extends Equatable {
  const MyOrderEvent();

  @override
  List<Object> get props => [];
}

class LoadMyOrder extends MyOrderEvent {
  @override
  List<Object> get props => [];
}

class UpdateMyOrder extends MyOrderEvent {
  final List<Order> listOrder;
  const UpdateMyOrder({
    required this.listOrder,
  });
  @override
  List<Object> get props => [listOrder];
}

class UpdateStateMyOrder extends MyOrderEvent {
  final Order order;
  final String state;
  const UpdateStateMyOrder({
    required this.order,
    required this.state,
  });
  @override
  List<Object> get props => [order, state];
}
