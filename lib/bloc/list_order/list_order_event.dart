part of 'list_order_bloc.dart';

abstract class ListOrderEvent extends Equatable {
  const ListOrderEvent();

  @override
  List<Object> get props => [];
}

class LoadListOrder extends ListOrderEvent {
  final Order order;

  LoadListOrder({required this.order});

  @override
  List<Object> get props => [order];
}
