part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class LoadProductSearch extends SearchEvent {
  const LoadProductSearch(this.query);
  final String query;
  @override
  List<Object> get props => [query];
}

class ClearSearch extends SearchEvent {
  const ClearSearch();
  @override
  List<Object> get props => [];
}


class FilterProduct extends SearchEvent {
  const FilterProduct(this.queryText, this.brand, this.gender, this.priceRange, this.sort);
  final String queryText;
  final String brand; 
  final String gender;
  final RangeValues priceRange;
  final String sort;
  @override
  List<Object> get props => [queryText, brand, gender, priceRange, sort];
}

