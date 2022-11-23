import 'package:flutter/material.dart';

class DeliveryAddress extends StatelessWidget {
  const DeliveryAddress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 25,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Delivery Address',
                style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Nguyen Ba Khanh'),
              Text('+84 396891589'),
              Text(
                'Nha van hoa sinh vien, Linh Trung, Thu Duc, Ho Chi Minh',
                // maxLines: 3,
                // textAlign: TextAlign.left,
                // overflow: TextOverflow.ellipsis,
              )
            ]),
          )
        ],
      ),
    );
  }
}
