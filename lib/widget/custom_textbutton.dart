import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 + 40,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            )),
            foregroundColor: MaterialStateProperty.all(Colors.transparent),
            backgroundColor: MaterialStateProperty.all(Colors.black)),
        onPressed: () {
          onPressed();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_mall,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
