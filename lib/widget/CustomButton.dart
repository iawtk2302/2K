import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onTap, required this.text});
  final Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: InkWell(
                    onTap: onTap,
                    child: Container(                
                      child: Center(
                          child: Text(text,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white))),
                      height: 50,
                      width: size.width * 0.85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black),
                    ),
                  ),
                );
  }
}