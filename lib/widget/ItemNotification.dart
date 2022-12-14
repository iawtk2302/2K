
import '../model/notification.dart';
import 'package:flutter/material.dart';

class ItemNotification extends StatelessWidget {
  const ItemNotification({super.key, required this.notification});
  final NotificationCustom notification;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Image.network(notification.image!,height: 55,width: 55,fit: BoxFit.cover,),
            SizedBox(width:20),
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification.title!,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                Text(notification.body!,style: TextStyle(fontSize: 16),)
              ],
            ))
          ],),
        ),
      ),
    );
  }
}