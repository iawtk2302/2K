import 'package:flutter/material.dart';
import 'package:sneaker_app/bloc/order/orderReponsitory.dart';
import 'package:sneaker_app/model/address.dart';

class ItemTypeShipping extends StatelessWidget {
  const ItemTypeShipping({super.key,this.icon,this.onTap, required this.typeShipping, required this.address});
  final IconButton? icon;
  final TypeShipping typeShipping;
  final Address address;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Row(children: [
              Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color(0xFFE3E3E3)
              ),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xFF161616)
                  ),
                  child: Container(
                    child: Icon(Icons.location_on,color: Colors.white,),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(typeShipping.shortName.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  SizedBox(height: 4,),
                  Container(
                    width: 180,
                    child: Text('',
                    overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
            ],),
            icon ?? Container()
          ]),
        ),
      ),
    );
  }
}