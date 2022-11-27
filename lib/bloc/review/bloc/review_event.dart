part of 'review_bloc.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object> get props => [];
}

class LoadReview extends ReviewEvent{
  const LoadReview(this.product);
  final Product product;
  @override
  List<Object> get props => [];
}

class ChooseCategory extends ReviewEvent{
  const ChooseCategory(this.category);
  final String category;
  @override
  List<Object> get props => [];
}
