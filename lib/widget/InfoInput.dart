import 'package:flutter/material.dart';

class InfoInput extends StatelessWidget {
  const InfoInput(
      {super.key,
      this.controller,
      this.validator,
      this.keyboardType,
      required this.hintText,
      this.suffixIcon,
      this.enabled,
      this.readOnly,
      this.maxLength});
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final TextInputType? keyboardType;
  final String hintText;
  final IconButton? suffixIcon;
  final bool? enabled;
  final bool? readOnly;
  final int? maxLength;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.black,
            ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          width: size.width * 0.85,
          child: TextFormField(
            controller: controller,
            maxLength: maxLength,
            validator: validator,
            enabled: enabled,
            readOnly: readOnly ?? false,
            keyboardType: keyboardType,
            textAlignVertical: TextAlignVertical.center,
            cursorColor: Theme.of(context).iconTheme.color,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                hintText: hintText,
                errorStyle: TextStyle(fontSize: 14),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: readOnly == false
                      ? const BorderSide(
                          width: 1.5,
                        )
                      : const BorderSide(width: 0, style: BorderStyle.none),
                ),
                suffixIcon: suffixIcon,
                contentPadding:
                    const EdgeInsets.only(left: 20, bottom: 20, top: 20),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      width: 0,
                      color: Color(0xFFFAFAFA),
                      style: BorderStyle.none),
                ),
                filled: true,
                fillColor: Theme.of(context).cardColor),
          ),
        ),
      ),
    );
  }
}
