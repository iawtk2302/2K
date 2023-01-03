part of 'my_order_bloc.dart';

abstract class MyOrderState extends Equatable {
  const MyOrderState();

  @override
  List<Object> get props => [];
}

class MyOrderLoading extends MyOrderState {}

class MyOrderLoaded extends MyOrderState {
  final List<MyOrder> listOrder;
  const MyOrderLoaded({
    required this.listOrder,
  });

  @override
  List<Object> get props => [listOrder];
}

class MyOrderError extends MyOrderState {}
