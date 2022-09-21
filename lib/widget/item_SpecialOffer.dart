import 'package:flutter/material.dart';

class Item_SpecialOffer extends StatelessWidget {
  const Item_SpecialOffer({
    Key? key,
    required this.percentDiscount,
    required this.imgUri,
  }) : super(key: key);
  final String percentDiscount;
  final String imgUri;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 32,
      height: 180,
      decoration: BoxDecoration(
          color: Color(0xFFCD031C),
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Row(children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Spacer(),
              Text(
                percentDiscount,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.white,
                    fontFamily: 'Urbanist'),
              ),
              Spacer(),
              Text('Today\'s Special!',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Urbanist')),
              Spacer(),
              Text('Get discount for every order, only valid for today',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontFamily: 'Urbanist')),
              Spacer(),
              Spacer(),
            ],
          ),
        )),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            child: Image(
              height: double.infinity,
              fit: BoxFit.cover,
              image: NetworkImage(imgUri),
            ),
          ),
        )
      ]),
    );
  }
}
