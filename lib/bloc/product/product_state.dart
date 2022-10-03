part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> listProduct;
  final List<Category> listCategory;
  ProductLoaded({required this.listCategory, required this.listProduct});
  //

  @override
  List<Object> get props => [listProduct];
}
