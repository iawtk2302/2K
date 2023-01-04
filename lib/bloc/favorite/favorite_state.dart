part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<Product> products;

  FavoriteLoaded(this.products);
  @override
  List<Object> get props => [products];
}
