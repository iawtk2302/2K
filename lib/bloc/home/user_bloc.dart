import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/User.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
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
            dateOfbirth: value.get('dateOfbirth').toString(),
          );
          emit(UserExist(user));
        } else {
          emit(UserNotExist());
        }
      });
    });
    on<SubmitInfoUser>((event, emit) {
      emit(UserLoading());
      emit(UserExist(event.user));
    });
  }
}
