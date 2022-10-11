part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object> get props => [];
}

enum SortBy { featured, newest, lowHigh, highLow }

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> listProduct;
  final List<Category> listCategory;
  final SortBy sortBy;
  final List<String> gender;
  ProductLoaded({
    required this.gender,
    required this.listCategory,
    required this.listProduct,
    required this.sortBy,
  });
  //

  @override
  List<Object> get props => [listProduct, listCategory];
}
