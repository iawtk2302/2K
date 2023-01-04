import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.hasLeftIcon,
    required this.isDark,
    required this.hasRightIcon,
  }) : super(key: key);
  final String text;
  final Function onPressed;
  final bool hasLeftIcon;
  final bool isDark;
  final bool hasRightIcon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: MediaQuery.of(context).size.width / 2 + 40,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(10),
            overlayColor:
                MaterialStateProperty.all(Color(0xFFE5E5E5).withOpacity(0.4)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            )),
            foregroundColor: MaterialStateProperty.all(Colors.transparent),
            backgroundColor: !isDark
                ? MaterialStateProperty.all(Theme.of(context).backgroundColor)
                : MaterialStateProperty.all(
                    Theme.of(context).primaryIconTheme.color)),
        onPressed: () {
          onPressed();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            hasLeftIcon
                ? Row(
                    children: [
                      Icon(
                        Icons.local_mall,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  )
                : SizedBox(),
            Text(
              text,
              style: TextStyle(
                  
                  fontSize: 18,
                  // color: isDark ? Colors.white : Colors.black,
                  color: isDark
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryIconTheme.color,
                  fontWeight: FontWeight.w600),
            ),
            hasRightIcon
                ? Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.double_arrow,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
