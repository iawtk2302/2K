import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/User.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserLoading()) {
    on<LoadInfoUser>((event, emit) async {
      emit(UserLoading());
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
            emit(UserExist(user));
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
      if (event.user.pin != null && event.user.pin!.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('User')
            .doc(event.user.idUser)
            .update({
          'pin': event.user.pin,
        }).then((value) => emit(UserExist(event.user)));
      } else {
        emit(UserExistExceptPinCode(user: event.user));
      }
    });
    on<UpdatePinUser>((event, emit) async {
      if (event.user.pin != null && event.user.pin!.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('User')
            .doc(event.user.idUser)
            .update({
          'pin': event.user.pin,
        }).then((value) => emit(UserExist(event.user)));
      }
    });
  }
}
