part of 'brand_bloc.dart';

abstract class BrandState extends Equatable {
  const BrandState();

  @override
  List<Object> get props => [];
}

class BrandLoading extends BrandState {}

class BrandLoaded extends BrandState {
  final List<Brand> listBrand;

  BrandLoaded({required this.listBrand});
  @override
  List<Object> get props => [listBrand];
}
