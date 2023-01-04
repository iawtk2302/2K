part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadProductFavorite extends FavoriteEvent {}
