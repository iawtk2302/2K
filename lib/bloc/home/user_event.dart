part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadInfoUser extends UserEvent {}

class SubmitInfoUser extends UserEvent {
  final Customer user;
  const SubmitInfoUser({required this.user});
  @override
  List<Object> get props => [user];
}

class UpdatePinUser extends UserEvent {
  final Customer user;

  const UpdatePinUser({required this.user});

  @override
  List<Object> get props => [user];
}
