part of 'card_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final Cart cart;

  const CartLoaded({this.cart = const Cart()});
  @override
  List<Object> get props => [cart];
}

class CardError extends CartState {}
