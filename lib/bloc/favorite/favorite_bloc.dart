import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sneaker_app/model/favorite.dart';
import 'package:sneaker_app/model/product.dart';
import 'package:sneaker_app/service/favorite_repository.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteRepository favoriteRepository = FavoriteRepository();
  FavoriteBloc() : super(FavoriteLoading()) {
    on<LoadProductFavorite>((event, emit) async {
      emit(FavoriteLoading());
      // print(event.favorites[0].idProduct);
      List<Product> products = await favoriteRepository.loadProductFavorite(
          event.favorites.map((e) => e.idProduct!).toList());
      // print(products);
      emit(FavoriteLoaded(products));
    });
  }
}
