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
      height: 55,
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
            backgroundColor: isDark
                ? MaterialStateProperty.all(Colors.black)
                : MaterialStateProperty.all(Colors.white)),
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
                        color: Colors.white,
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
                  fontFamily: 'Urbanist',
                  fontSize: 18,
                  color: isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            hasRightIcon
                ? Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.double_arrow,
                      color: Colors.white,
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
