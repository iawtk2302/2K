import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sneaker_app/themes/ThemeService.dart';

class CustomSwitchButton extends StatefulWidget {
  const CustomSwitchButton({super.key});

  @override
  State<CustomSwitchButton> createState() => _CustomSwitchButtonState();
}

class _CustomSwitchButtonState extends State<CustomSwitchButton> {
  bool light = true;
  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: light,
      activeColor: Colors.white,
      onChanged: (bool value) {
        ThemeService().switchTheme();
        // This is called when the user toggles the switch.
        setState(() {
          light = value;
        });
      },
    );
  }
}
