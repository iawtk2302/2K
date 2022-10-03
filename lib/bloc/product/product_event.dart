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
  List<Object> get props => [];
}
