import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../widget/custom_textbutton.dart';

class SetFingerPrint extends StatefulWidget {
  const SetFingerPrint({super.key});

  @override
  State<SetFingerPrint> createState() => _SetFingerPrintState();
}

class _SetFingerPrintState extends State<SetFingerPrint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Set Your Fingerprint',
        ),
      ),
      body: SizedBox(
        child: Column(children: [
          const SizedBox(
            height: 32,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 32),
            child: Text(
              'Add a Fingerprint to make your account more secure',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Urbanist', fontSize: 16),
            ),
          ),
          const Expanded(
            child: Icon(
              Icons.fingerprint,
              size: 300,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 32),
            child: Text(
              'Please put your finger on the fingerprint scanner to get started',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Urbanist', fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextButton(
                            hasLeftIcon: false,
                            isDark: false,
                            hasRightIcon: false,
                            text: 'Skip',
                            onPressed: () {},
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextButton(
                            hasLeftIcon: false,
                            isDark: true,
                            hasRightIcon: false,
                            text: 'Continue',
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
