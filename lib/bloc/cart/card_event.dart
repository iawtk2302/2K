part of 'card_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {
  @override
  List<Object> get props => [];
}

class CartProductAdd extends CartEvent {
  final Product product;

  const CartProductAdd({required this.product});
  @override
  List<Object> get props => [];
}

class CartProductRemove extends CartEvent {
  final Product product;

  const CartProductRemove({required this.product});
  @override
  List<Object> get props => [];
}
