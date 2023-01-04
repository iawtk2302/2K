part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

// class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserExistExceptPinCode extends UserState {
  final Customer user;

  UserExistExceptPinCode({required this.user});
  @override
  List<Object> get props => [user];
}

class UserExist extends UserState {
  final Customer user;
  final int notification;
  const UserExist(this.user, this.notification);

  @override
  List<Object> get props => [user];
}

class UserNotExist extends UserState {
  const UserNotExist();

  @override
  List<Object> get props => [];
}
