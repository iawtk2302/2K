part of 'review_bloc.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();
  
  @override
  List<Object> get props => [];
}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewLoaded extends ReviewState {
  ReviewLoaded(this.listReview, this.selectedCategory);
  final List<String> listCategory=['All','5','4','3','2','1'];
  final List<Review> listReview;
  final String selectedCategory;
  
  @override
  List<Object> get props => [listReview,selectedCategory];
}
