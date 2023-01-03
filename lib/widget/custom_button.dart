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
        backgroundColor:text=="Delete"?Color.fromARGB(255, 232, 75, 88): ThemeService().theme==ThemeMode.dark?Colors.white:Colors.black,
        elevation: 0,
        minimumSize: Size(350,50),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))
        )
      ),
      onPressed: onTap,
      child: Text(text,style: TextStyle(color:text=="Delete"?Colors.white: ThemeService().theme!=ThemeMode.dark?Colors.white:Colors.black, fontSize: 16, fontWeight: FontWeight.w700),),
    );
  }
}