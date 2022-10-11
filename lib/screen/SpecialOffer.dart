import 'package:flutter/material.dart';
import 'package:sneaker_app/modal/banner.dart';

import 'package:sneaker_app/widget/item_SpecialOffer.dart';

class SpecialOffer extends StatefulWidget {
  const SpecialOffer({
    Key? key,
    required this.listBanner,
  }) : super(key: key);
  final List<CustomBanner> listBanner;
  @override
  State<SpecialOffer> createState() => _SpecialOfferState();
}

class _SpecialOfferState extends State<SpecialOffer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0,
          title: Text(
            'Special Offers',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontFamily: 'Urbanist'),
          )),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  scrollDirection: Axis.vertical,
                  itemCount: widget.listBanner.length,
                  itemBuilder: ((context, index) => Column(
                        children: [
                          Item_SpecialOffer(
                              imgUri: widget.listBanner[index].image),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ))),
            ),
          ),
        ],
      ),
    );
  }
}
