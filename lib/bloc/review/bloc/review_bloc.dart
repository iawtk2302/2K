import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sneaker_app/bloc/review/bloc/ReviewRepository.dart';
import 'package:sneaker_app/model/product.dart';

import '../../../model/review.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc() : super(ReviewInitial()) {
    List<Review> temp=[];
    on<LoadReview>((event, emit) async{
      emit(ReviewLoading());
      List<Review> listReview=await ReviewRepository().getReviewProduct(event.product);
      temp.addAll(listReview);
      emit(ReviewLoaded(listReview, "All"));
    });
    on<ChooseCategory>((event, emit) async{
      emit(ReviewLoading());
      final selectedCategory=event.category;
      List<Review> listReview=[];
      if(selectedCategory!='All') {
        listReview.addAll(temp.where((element) => element.star.toString()==event.category).toList());
      } else{
        listReview.addAll(temp);
      }
      emit(ReviewLoaded(listReview, selectedCategory));
    });
  }
}
