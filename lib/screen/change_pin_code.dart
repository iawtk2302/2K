import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../bloc/home/user_bloc.dart';
import '../model/User.dart';
import '../widget/custom_textbutton.dart';

class ChangePinCode extends StatefulWidget {
  const ChangePinCode({super.key});

  @override
  State<ChangePinCode> createState() => _ChangePinCodeState();
}

class _ChangePinCodeState extends State<ChangePinCode> {
  String text = 'Enter your old PIN code';
  int phase = 1;
  String newPin = '';
  String confirmPin = '';
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (phase) {
      case 1:
        text = 'Enter your old PIN code';
        break;
      case 2:
        text = 'Enter your new PIN code';
        break;
      case 3:
        text = 'Enter confirm PIN code';
        break;
      default:
        text = '';
        break;
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Create New Pin',
          ),
        ),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 32),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is UserExist) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 32.0, left: 32, right: 32),
                          child: PinCodeTextField(
                              autoDisposeControllers: false,
                              obscureText: true,
                              controller: controller,
                              keyboardType: TextInputType.number,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(10),
                                fieldHeight: 45,
                                fieldWidth: 55,
                                activeFillColor: Colors.white,
                                inactiveFillColor: Theme.of(context).cardColor,
                                inactiveColor:
                                    Theme.of(context).backgroundColor,
                                selectedColor:
                                    Theme.of(context).primaryIconTheme.color,
                                activeColor:
                                    Theme.of(context).primaryIconTheme.color,
                              ),
                              animationDuration: Duration(milliseconds: 100),
                              animationType: AnimationType.none,
                              appContext: context,
                              onCompleted: ((value) {
                                solve(value, state.user);
                              }),
                              length: 4,
                              onChanged: (value) {
                                // debugPrint('code');
                              }),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 32.0),
                child: CustomTextButton(
                  hasLeftIcon: false,
                  isDark: true,
                  hasRightIcon: false,
                  text: 'Continue',
                  onPressed: () {},
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  bool solve(String value, Customer? user) {
    switch (phase) {
      case 1:
        {
          if (value == user!.pin) {
            debugPrint('correct code');
            setState(() {
              phase = 2;
              controller.text = '';
            });
          } else {
            debugPrint('wrong code');
          }
        }
        break;
      case 2:
        {
          newPin = value;
          setState(() {
            phase = 3;
            controller.text = '';
          });
        }
        break;
      case 3:
        {
          confirmPin = value;
          if (newPin == confirmPin && newPin.isNotEmpty) {
            debugPrint('success');
            Customer newUser = user!;
            newUser.pin = newPin;
            BlocProvider.of<UserBloc>(context)
                .add(SubmitInfoUser(user: newUser));
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
              'Change PIN successful',
              textAlign: TextAlign.center,
            )));
            Navigator.pop(context);
          } else {
            debugPrint('fail');
            setState(() {
              phase = 2;
              // controller.text = '';
            });
          }
        }
    }

    return false;
  }
}
