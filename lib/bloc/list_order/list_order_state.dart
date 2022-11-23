// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'list_order_bloc.dart';

abstract class ListOrderState extends Equatable {
  const ListOrderState();

  @override
  List<Object> get props => [];
}

class ListOrderLoading extends ListOrderState {}

class ListOrderLoaded extends ListOrderState {
  final List<ProductCart> listProduct;
  const ListOrderLoaded({
    required this.listProduct,
  });
  @override
  List<Object> get props => [listProduct];
}

class ListOrderError extends ListOrderState {}
