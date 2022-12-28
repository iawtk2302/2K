part of 'biometric_auth_bloc.dart';

@immutable
abstract class BiometricAuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadBiometricAuth extends BiometricAuthEvent {}

class ChangeStateBiometricAuth extends BiometricAuthEvent {
  final bool value;

  ChangeStateBiometricAuth({required this.value});
  @override
  List<Object> get props => [value];
}
