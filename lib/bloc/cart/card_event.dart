// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'card_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {
  const LoadCart();
  @override
  List<Object> get props => [];
}

class CartProductAdd extends CartEvent {
  final ProductCart product;

  const CartProductAdd({required this.product});
  @override
  List<Object> get props => [];
}

class CartProductRemove extends CartEvent {
  final ProductCart product;

  const CartProductRemove({required this.product});
  @override
  List<Object> get props => [];
}

class CartProductUpdate extends CartEvent {
  final ProductCart product;

  const CartProductUpdate({required this.product});
  @override
  List<Object> get props => [];
}
