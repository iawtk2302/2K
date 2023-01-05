part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadProductFavorite extends FavoriteEvent {
  // final String idUser;
  final List<Favorite> favorites;

  LoadProductFavorite({required this.favorites});
  @override
  List<Object> get props => [favorites];
}
