part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Brand> listBrand;
  final List<CustomBanner> banner;
  final List<Product> listProduct;
  HomeLoaded({required this.banner, required this.listBrand, required this.listProduct});
  @override
  List<Object> get props => [listBrand, banner, listProduct];
}
