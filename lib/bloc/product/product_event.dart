part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProduct extends ProductEvent {
  final String idBrand;
  final BuildContext context;

  final SortBy sortBy;
  final List<String> gender;
  LoadProduct(
      {required this.sortBy,
      required this.gender,
      required this.context,
      required this.idBrand});
  @override
  List<Object> get props => [idBrand, context, sortBy, gender];
}

class ReLoadProduct extends ProductEvent {
  final String idCategory;
  final BuildContext context;
  final List<Category> listCategory;
  final SortBy sortBy;
  final List<String> gender;
  ReLoadProduct(
      {required this.sortBy,
      required this.gender,
      required this.listCategory,
      required this.context,
      required this.idCategory});
  @override
  List<Object> get props => [idCategory, context, listCategory, sortBy, gender];
}

class ReactProduct extends ProductEvent {
  final String idProduct;
  final String idUser;
  ReactProduct({
    required this.idProduct,
    required this.idUser,
  });
  @override
  List<Object> get props => [idProduct, idUser];
}

class Sort_Filter_Product extends ProductEvent {
  final SortBy sortBy;
  final List<String> gender;
  final BuildContext context;
  final List<Product> listProduct;
  final List<Category> listCategory;
  Sort_Filter_Product({
    required this.listProduct,
    required this.context,
    required this.listCategory,
    required this.sortBy,
    required this.gender,
  });
  @override
  List<Object> get props =>
      [sortBy, gender, context, listProduct, listCategory];
}
