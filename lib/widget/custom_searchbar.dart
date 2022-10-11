import 'package:flutter/material.dart';

import '../screen/SearchScreen.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    required this.hintText,
    required this.icon,
    required this.isPassword,
  });
  final String hintText;
  final Icon icon;
  final bool isPassword;
  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController controller = TextEditingController();
  String searchtext = '';
  bool isShowPassword = false;
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
                onTap: () async {
                  controller.text = await showSearch(
                      context: context,
                      delegate: CustomSearchScreen(controller.text));
                },
                keyboardType: TextInputType.none,
                obscureText: !widget.isPassword
                    ? false
                    : isShowPassword
                        ? true
                        : false,
                decoration: InputDecoration(
                  focusColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: Colors.white),
                  ),
                  prefixIcon: widget.icon,
                  suffixIcon: widget.isPassword
                      ? IconButton(
                          padding: const EdgeInsets.all(1.0),
                          icon: Icon(Icons.tune),
                          onPressed: () {
                            setState(() {
                              isShowPassword = !isShowPassword;
                            });
                          },
                        )
                      : null,
                  hintText: widget.hintText,
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
