import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/User.dart';
import '../../model/notification.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserLoading()) {
    on<LoadInfoUser>((event, emit) async {
      emit(UserLoading());
      final notifications=FirebaseFirestore.instance.collection("Notification");
  List<NotificationCustom> listNotification=[];
  await notifications.get().then((value) => listNotification.addAll(value.docs.map((e) => NotificationCustom.fromJson(e.data())).toList()));
  int amount=listNotification.length;
      await FirebaseFirestore.instance
          .collection('User')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        if (value.exists) {
          // print(value.data()!.length.toString());
          final user = Customer(
            idUser: value.get('idUser').toString(),
            lastName: value.get('lastName').toString(),
            firstName: value.get('firstName').toString(),
            image: value.get('image').toString(),
            gender: value.get('gender').toString(),
            phone: value.get('phone').toString(),
            email: value.get('email').toString(),
            pin: value.get('pin'),
            dateOfbirth: value.get('dateOfbirth').toString(),
          );
          if (user.pin != null && user.pin!.isNotEmpty) {
            print(user.pin);
            emit(UserExist(user,amount));
          } else {
            emit(UserExistExceptPinCode(user: user));
          }
          // emit(UserExist(user));
        } else {
          emit(const UserNotExist());
        }
      });
    });
    on<SubmitInfoUser>((event, emit) async {
      emit(UserLoading());
      final notifications=FirebaseFirestore.instance.collection("Notification");
  List<NotificationCustom> listNotification=[];
  await notifications.get().then((value) => listNotification.addAll(value.docs.map((e) => NotificationCustom.fromJson(e.data())).toList()));
  int amount=listNotification.length;
      if (event.user.pin != null) {
        await FirebaseFirestore.instance
            .collection('User')
            .doc(event.user.idUser)
            .update({
          'pin': event.user.pin,
        }).then((value) => emit(UserExist(event.user,amount)));
      } else {
        emit(UserExistExceptPinCode(user: event.user));
      }
    });
    on<UpdatePinUser>((event, emit) async {
      final notifications=FirebaseFirestore.instance.collection("Notification");
  List<NotificationCustom> listNotification=[];
  await notifications.get().then((value) => listNotification.addAll(value.docs.map((e) => NotificationCustom.fromJson(e.data())).toList()));
  int amount=listNotification.length;
      if (event.user.pin != null || event.user.pin == '') {
        await FirebaseFirestore.instance
            .collection('User')
            .doc(event.user.idUser)
            .update({
          'pin': event.user.pin,
        }).then((value) => emit(UserExist(event.user,amount)));
      }
    });
  }
}
