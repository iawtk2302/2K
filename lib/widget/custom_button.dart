import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_app/themes/ThemeService.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, required this.text, required this.onTap, this.color, this.colorText});
  final String text;
  final Function() onTap;
  final Color? color;
  final Color? colorText;
  @override
  Widget build(BuildContext context) { 
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ThemeService().theme==ThemeMode.dark?Colors.white:Colors.black,
        elevation: 0,
        minimumSize: Size(350,50),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))
        )
      ),
      onPressed: onTap,
      child: Text(text,style: TextStyle(color: ThemeService().theme!=ThemeMode.dark?Colors.white:Colors.black, fontSize: 16, fontWeight: FontWeight.w700),),
    );
  }
}