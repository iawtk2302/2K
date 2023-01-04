import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sneaker_app/router/routes.dart';
import 'package:sneaker_app/screen/set_fingerprint.dart';
import 'package:sneaker_app/widget/custom_textbutton.dart';

import '../bloc/biometric_auth/biometric_auth_bloc.dart';
import 'change_password.dart';
import 'change_pin_code.dart';

class Security extends StatefulWidget {
  const Security({super.key});

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  final LocalAuthentication auth = LocalAuthentication();

  bool authenticated = false;
  bool light = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            // color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Security',
          style: TextStyle(
              // color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
              fontFamily: 'Urbanist'),
        ),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              BlocBuilder<BiometricAuthBloc, BiometricAuthState>(
                builder: (context, state) {
                  if (state is BiometricAutLoading ||
                      state is BiometricAutNotExist) {
                    return const SizedBox();
                  } else if (state is BiometricAuthLoaded) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Biometric ID',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Switch(
                          // This bool value toggles the switch.
                          value: state.authenticated,
                          activeColor: Theme.of(context).primaryIconTheme.color,
                          onChanged: (bool value) async {
                            if (!mounted) {
                              return;
                            }
                            context
                                .read<BiometricAuthBloc>()
                                .add(ChangeStateBiometricAuth(value: value));
                          },
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangePinCode(),
                        ));
                  },
                  text: 'Change PIN',
                  hasLeftIcon: false,
                  isDark: true,
                  hasRightIcon: false),
              const SizedBox(
                height: 16,
              ),
              CustomTextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangePassword(),
                        ));
                  },
                  text: 'Change Password',
                  hasLeftIcon: false,
                  isDark: true,
                  hasRightIcon: false)
            ],
          ),
        ),
      ]),
    );
  }
}
