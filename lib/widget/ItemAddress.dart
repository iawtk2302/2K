import 'package:flutter/material.dart';
import 'package:sneaker_app/model/address.dart';

class ItemAddress extends StatelessWidget {
  const ItemAddress({super.key, required this.address,this.icon,this.onTap});
  final Address address;
  final IconButton? icon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
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
                  Row(children: [
                    Text(address.name!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    Padding(
                      padding: const EdgeInsets.only(left:6.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.circular(6)
                        ),
                        child:address.isDefault==true ? const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6,vertical: 4),
                          child: Text("Default",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
                        ):Container(),
                      ),
                    )
                  ],),
                  SizedBox(height: 4,),
                  Container(
                    width: 180,
                    child: Text(address.detail.toString(),
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