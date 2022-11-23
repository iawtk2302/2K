import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Track_delivery extends StatelessWidget {
  const Track_delivery({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          const Icon(FontAwesomeIcons.circleDot),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Order in transit - Dec 17',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Urbanist',
                          fontSize: 16),
                    ),
                    const Text('15:20 pm'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('32 Manchester Ave, Ringgold, GA 30534'),
              ],
            ),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.only(left: 11.0),
          child: Column(
            children: [
              const Text('\''),
              const Text('\''),
              const Text('\''),
            ],
          ),
        ),
        Row(children: [
          const Icon(FontAwesomeIcons.circleDot),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Order in transit - Dec 17',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Urbanist',
                          fontSize: 16),
                    ),
                    const Text('15:20 pm'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('32 Manchester Ave, Ringgold, GA 30534'),
              ],
            ),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.only(left: 11.0),
          child: Column(
            children: [
              const Text('\''),
              const Text('\''),
              const Text('\''),
            ],
          ),
        ),
        Row(children: [
          const Icon(FontAwesomeIcons.circleDot),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Order in transit - Dec 17',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Urbanist',
                          fontSize: 16),
                    ),
                    const Text('15:20 pm'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('32 Manchester Ave, Ringgold, GA 30534'),
              ],
            ),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.only(left: 11.0),
          child: Column(
            children: [
              const Text('\''),
              const Text('\''),
              const Text('\''),
            ],
          ),
        ),
        Row(children: [
          const Icon(FontAwesomeIcons.circleDot),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Order in transit - Dec 17',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Urbanist',
                          fontSize: 16),
                    ),
                    const Text('15:20 pm'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('32 Manchester Ave, Ringgold, GA 30534'),
              ],
            ),
          ),
        ]),
      ],
    );
  }
}
