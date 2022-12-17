import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ItemContact(
            icon: Icons.headset,
            text: 'Customer Service'.tr,
            onPress: () {
              print('object');
            },
          ),
          SizedBox(
            height: 16,
          ),
          ItemContact(
            icon: FontAwesomeIcons.whatsapp,
            text: 'WhatsApp',
            onPress: () {},
          ),
          SizedBox(
            height: 16,
          ),
          ItemContact(
            icon: Icons.language,
            text: 'Website',
            onPress: () {},
          ),
          SizedBox(
            height: 16,
          ),
          ItemContact(
            icon: Icons.facebook,
            text: 'Facebook',
            onPress: () {},
          ),
          SizedBox(
            height: 16,
          ),
          ItemContact(
            icon: FontAwesomeIcons.twitter,
            text: 'Twitter',
            onPress: () {},
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}

class ItemContact extends StatelessWidget {
  const ItemContact({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPress,
  }) : super(key: key);
  final IconData icon;
  final String text;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        overlayColor:
            MaterialStateProperty.all(Color.fromARGB(255, 225, 224, 224)),
        backgroundColor: MaterialStateProperty.all(Theme.of(context).cardColor),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 22)),
      ),
      onPressed: () {
        onPress();
      },
      child: Row(children: [
        Icon(
          icon,
          // color: Colors.black,
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          text,
          style: const TextStyle(
              // color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 17,
              fontFamily: 'Urbanist'),
        ),
      ]),
    );
  }
}
// margin: const EdgeInsets.only(bottom: 16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 2,
//               blurRadius: 2,
//               offset: const Offset(0, 2), // changes position of shadow
//             ),
//           ],
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 22),