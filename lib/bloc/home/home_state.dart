part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Brand> listBrand;
  final Banner banner;
  HomeLoaded({required this.banner, required this.listBrand});
  @override
  List<Object> get props => [listBrand, banner];
}