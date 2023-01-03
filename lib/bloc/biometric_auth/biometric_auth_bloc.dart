import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'biometric_auth_event.dart';
part 'biometric_auth_state.dart';

class BiometricAuthBloc extends Bloc<BiometricAuthEvent, BiometricAuthState> {
  final LocalAuthentication auth = LocalAuthentication();

  BiometricAuthBloc() : super(BiometricAutLoading()) {
    on<LoadBiometricAuth>((event, emit) async {
      final List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();
      if (availableBiometrics.isEmpty) {
        emit(BiometricAutNotExist());
      } else {
        final prefs = await SharedPreferences.getInstance();

        try {
          bool? useBiometric = prefs.getBool('useBiometric');
          if (useBiometric == null) {
            prefs.setBool('useBiometric', false);
            emit(BiometricAuthLoaded(authenticated: false));
          } else {
            emit(BiometricAuthLoaded(authenticated: useBiometric));
          }
        } catch (e) {}
      }
    });
    on<ChangeStateBiometricAuth>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      // final LocalAuthentication auth = LocalAuthentication();
      bool authenticated;

      if (event.value == true) {
        print('object');
        authenticated = await auth.authenticate(
          localizedReason:
              'Scan your fingerprint (or face or whatever) to authenticate',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ),
        );
        if (authenticated) {
          prefs.setBool('useBiometric', true);
          emit(BiometricAuthLoaded(authenticated: true));
        }
        // try {} catch (e) {}
      } else {
        prefs.setBool('useBiometric', false);
        emit(BiometricAuthLoaded(authenticated: false));
      }
    });
  }
}
