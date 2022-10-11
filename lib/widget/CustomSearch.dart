import 'package:flutter/material.dart';
import 'package:sneaker_app/router/routes.dart';

import '../screen/SearchScreen.dart';

class CustomSearch extends StatelessWidget {
   CustomSearch({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.controller,
    this.onSubmitted
  });
  final String hintText;
  final Icon prefixIcon;
  final Icon? suffixIcon;
  TextEditingController? controller = TextEditingController();
  Function()? onTap;
  Function(String)? onSubmitted;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: Colors.black,
                ),
          ),
          child: Material(
            color: Color(0xFFF5F5F5),
            child: TextField(
                controller: controller,
                onSubmitted: onSubmitted,
                onTap:onTap,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  focusColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(width: 1, color: Colors.black),
                  ),
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  hintText: hintText,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: Colors.white),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
