part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProduct extends ProductEvent {
  final String idBrand;
  final BuildContext context;
  LoadProduct({required this.context, required this.idBrand});
  @override
  List<Object> get props => [idBrand, context];
}

class ReLoadProduct extends ProductEvent {
  final String idCategory;
  final BuildContext context;
  final List<Category> listCategory;
  ReLoadProduct(
      {required this.listCategory,
      required this.context,
      required this.idCategory});
  @override
  List<Object> get props => [idCategory, context];
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
