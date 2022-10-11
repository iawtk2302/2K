part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState{
  final List<Product> listSearch;
  final List<String> listBrand;
  final List<String> listGender;
  final List<String> listSort;
  const SearchLoaded(this.listSearch, this.listBrand, this.listGender, this.listSort);

  @override
  List<Object> get props => [listSearch, listBrand, listGender, listSort];
}
