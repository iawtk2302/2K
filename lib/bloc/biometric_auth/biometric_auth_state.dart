part of 'biometric_auth_bloc.dart';

@immutable
abstract class BiometricAuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class BiometricAutLoading extends BiometricAuthState {}

class BiometricAutNotExist extends BiometricAuthState {}

class BiometricAuthLoaded extends BiometricAuthState {
  final bool authenticated;

  BiometricAuthLoaded({required this.authenticated});
  @override
  List<Object> get props => [authenticated];
}
