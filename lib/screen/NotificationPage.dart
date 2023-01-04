import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_app/widget/CustomAppBar.dart';
import 'package:sneaker_app/widget/ItemNotification.dart';
import 'package:sneaker_app/widget/Loading.dart';
import '../model/notification.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}
 Future<List<NotificationCustom>> getData()async{
  final notifications=FirebaseFirestore.instance.collection("Notification");
  List<NotificationCustom> listNotification=[];
  await notifications.get().then((value) => listNotification.addAll(value.docs.map((e) => NotificationCustom.fromJson(e.data())).toList()));
  return listNotification;
}
class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notification",onTap: () {
        Navigator.pop(context);
      },),
      body: Container(
        child: FutureBuilder<List<NotificationCustom>>(
          future: getData(),
          builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Loading());
        }
        if (snapshot.hasData) {
          return ListView.separated(
            itemCount: snapshot.data!.length,
            separatorBuilder: (BuildContext context, int index) { return Divider(height: 1,); }, itemBuilder: (BuildContext context, int index) { return ItemNotification(notification: snapshot.data![index],); },);
        }
        return Container();
        },),
      ),
    );
  }
}