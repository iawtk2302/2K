import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sneaker_app/widget/custom_textbutton.dart';

class CreatePinCode extends StatefulWidget {
  const CreatePinCode({super.key});

  @override
  State<CreatePinCode> createState() => _CreatePinCodeState();
}

class _CreatePinCodeState extends State<CreatePinCode> {
  @override
  Widget build(BuildContext context) {
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
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 50.0, vertical: 32),
                    child: Text(
                      'Add a PIN number to make your account more secure',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'Urbanist', fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 32.0, left: 32, right: 32),
                    child: PinCodeTextField(
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10),
                          fieldHeight: 45,
                          fieldWidth: 55,
                          activeFillColor: Colors.white,
                          inactiveFillColor: Theme.of(context).cardColor,
                          inactiveColor: Theme.of(context).backgroundColor,
                          selectedColor:
                              Theme.of(context).primaryIconTheme.color,
                          activeColor: Theme.of(context).primaryIconTheme.color,
                        ),
                        animationDuration: Duration(milliseconds: 100),
                        animationType: AnimationType.none,
                        appContext: context,
                        length: 4,
                        onChanged: (value) {}),
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
}
