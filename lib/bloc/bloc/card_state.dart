part of 'card_bloc.dart';

abstract class CardState extends Equatable {
  const CardState();
  
  @override
  List<Object> get props => [];
}

class CardInitial extends CardState {}
