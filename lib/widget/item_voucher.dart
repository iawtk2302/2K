import 'package:flutter/material.dart';
import 'package:sneaker_app/model/address.dart';
import 'package:sneaker_app/model/voucher.dart';

class ItemVoucher extends StatelessWidget {
  const ItemVoucher({super.key,this.icon,this.onTap, this.voucher});
  final IconButton? icon;
  final Voucher? voucher;
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
                color: Color(0xFF161616)
              ),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
               
                  ),
                  child: Container(
                    child: Icon(Icons.confirmation_number,color: Colors.white,),
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
                  Text(voucher!.name.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  SizedBox(height: 4,),
                  Container(
                    width: 180,
                    child: Text(voucher!.content.toString().toString(),
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