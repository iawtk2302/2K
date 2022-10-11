import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sneaker_app/modal/product.dart';
import 'package:sneaker_app/model/cart.dart';

part 'card_event.dart';
part 'card_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<LoadCart>((event, emit) async {
      await Future.delayed(Duration(seconds: 1));
      emit(const CartLoaded(cart: Cart(products: [])));
    });

    on<CartProductAdd>((event, emit) {
      if (state is CartLoaded) {
        final state = this.state as CartLoaded;
        emit(CartLoaded(
            cart: Cart(
                products: List.from(state.cart.products)..add(event.product))));
      }
    });

    on<CartProductRemove>((event, emit) {
      if (state is CartLoaded) {
        final state = this.state as CartLoaded;
        emit(CartLoaded(
            cart: Cart(
                products: List.from(state.cart.products)
                  ..remove(event.product))));
      }
    });
  }
}
