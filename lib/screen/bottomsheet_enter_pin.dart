import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sneaker_app/model/User.dart';

import '../bloc/home/user_bloc.dart';

class BottomSheetEnterPin extends StatefulWidget {
  const BottomSheetEnterPin({super.key});

  @override
  State<BottomSheetEnterPin> createState() => _BottomSheetEnterPinState();
}

class _BottomSheetEnterPinState extends State<BottomSheetEnterPin> {
  // final PIN = '1234';
  TextEditingController controller = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();
  bool authenticated = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    final prefs = await SharedPreferences.getInstance();
    bool? useBiometric = prefs.getBool('useBiometric');
    if (useBiometric == null) {
    } else if (useBiometric) {
      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if (!mounted) {
        print('unmounted');
        return;
      }
    }
    if (authenticated) {
      Navigator.pop(context, true);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      color: Theme.of(context).cardColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Header
            AppBar(
              backgroundColor: Theme.of(context).cardColor,
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.clear)),
              title: const Text(
                'Enter your Pin',
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0, left: 32, right: 32),
              child: PinCodeTextField(
                obscureText: true,
                controller: controller,
                keyboardType: TextInputType.none,
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    fieldHeight: 45,
                    fieldWidth: 55,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Theme.of(context).cardColor,
                    inactiveColor: Theme.of(context).backgroundColor,
                    selectedColor: Theme.of(context).primaryIconTheme.color,
                    activeColor: Theme.of(context).primaryIconTheme.color,
                    errorBorderColor: Colors.red),
                // onSaved:(newValue) => {},
                animationDuration: const Duration(milliseconds: 100),
                animationType: AnimationType.none,
                appContext: context,
                length: 4,

                onCompleted: (value) {
                  Customer user =
                      (context.read<UserBloc>().state as UserExist).user;
                  if (value == user.pin) {
                    Navigator.pop(context, true);
                  } else {}
                },
                onChanged: (value) {
                  print(controller.text);
                },
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.fingerprint),
                SizedBox(
                  width: 10,
                ),
                Text('Unlock with fingerprint')
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height * 0.087,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                              side: const BorderSide(
                                  width: 0.5, color: Colors.grey),
                            ),
                            onPressed: () {
                              if (controller.text.length < 4) {
                                controller.text += '1';
                              }
                            },
                            child: Center(
                              child: Text(
                                '1',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .color,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height * 0.087,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                              side: const BorderSide(
                                  width: 0.5, color: Colors.grey),
                            ),
                            onPressed: () {
                              if (controller.text.length < 4) {
                                controller.text += '2';
                              }
                            },
                            child: Center(
                              child: Text('2',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color,
                                      fontSize: 20)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height * 0.087,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                              side: const BorderSide(
                                  width: 0.5, color: Colors.grey),
                            ),
                            onPressed: () {
                              if (controller.text.length < 4) {
                                controller.text += '3';
                              }
                            },
                            child: Center(
                              child: Text('3',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color,
                                      fontSize: 20)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height * 0.087,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                              side: const BorderSide(
                                  width: 0.5, color: Colors.grey),
                            ),
                            onPressed: () {
                              if (controller.text.length < 4) {
                                controller.text += '4';
                              }
                            },
                            child: Center(
                              child: Text('4',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color,
                                      fontSize: 20)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height * 0.087,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                              side: const BorderSide(
                                  width: 0.5, color: Colors.grey),
                            ),
                            onPressed: () {
                              if (controller.text.length < 4) {
                                controller.text += '5';
                              }
                            },
                            child: Center(
                              child: Text('5',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color,
                                      fontSize: 20)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height * 0.087,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                              side: const BorderSide(
                                  width: 0.5, color: Colors.grey),
                            ),
                            onPressed: () {
                              if (controller.text.length < 4) {
                                controller.text += '6';
                              }
                            },
                            child: Center(
                              child: Text('6',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color,
                                      fontSize: 20)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height * 0.087,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                              side: const BorderSide(
                                  width: 0.5, color: Colors.grey),
                            ),
                            onPressed: () {
                              if (controller.text.length < 4) {
                                controller.text += '7';
                              }
                            },
                            child: Center(
                              child: Text('7',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color,
                                      fontSize: 20)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height * 0.087,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                              side: const BorderSide(
                                  width: 0.5, color: Colors.grey),
                            ),
                            onPressed: () {
                              if (controller.text.length < 4) {
                                controller.text += '8';
                              }
                            },
                            child: Center(
                              child: Text('8',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color,
                                      fontSize: 20)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height * 0.087,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                              side: const BorderSide(
                                  width: 0.5, color: Colors.grey),
                            ),
                            onPressed: () {
                              if (controller.text.length < 4) {
                                controller.text += '9';
                              }
                            },
                            child: Center(
                              child: Text('9',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color,
                                      fontSize: 20)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height * 0.087,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                              side: const BorderSide(
                                  width: 0.5, color: Colors.grey),
                            ),
                            onPressed: () {},
                            child: const Center(
                              child: Text(''),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height * 0.087,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                              side: const BorderSide(
                                  width: 0.5, color: Colors.grey),
                            ),
                            onPressed: () {
                              if (controller.text.length < 4) {
                                controller.text += '0';
                              }
                            },
                            child: Center(
                              child: Text('0',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color,
                                      fontSize: 20)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height * 0.087,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                              side: const BorderSide(
                                  width: 0.5, color: Colors.grey),
                            ),
                            onPressed: () {
                              if (controller.text.isNotEmpty) {
                                controller.text = controller.text
                                    .substring(0, controller.text.length - 1);
                              }
                            },
                            child: Center(
                              child: Icon(
                                Icons.backspace,
                                color: Theme.of(context).primaryIconTheme.color,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
