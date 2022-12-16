import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  String? idUser;
  String? lastName;
  String? firstName;
  String? dateOfbirth;
  String? email;
  String? phone;
  String? gender;
  String? image;
  String? pin;
  Customer(
      {this.idUser,
      this.image,
      this.lastName,
      this.firstName,
      this.dateOfbirth,
      this.email,
      this.phone,
      this.gender,
      this.pin});
  Map<String, dynamic> toJson() => {
        'lastName': lastName,
        'firstName': firstName,
        'dateOfbirth': dateOfbirth,
        'email': email,
        'phone': phone,
        'gender': gender,
        'image': image,
        'idUser': idUser,
        'pin': pin
      };
  Customer.fromJson(Map<String, dynamic> json) {
    idUser:
    json['idUser'];
    image:
    json['image'];
    lastName:
    json['lastName'];
    firstName:
    json['firstName'];
    dateOfbirth:
    json['dateOfbirth'];
    email:
    json['email'];
    phone:
    json['phone'];
    gender:
    json['gender'];
    pin:
    json['pin'];
  }

  @override
  List<Object?> get props => [
        idUser,
        lastName,
        firstName,
        dateOfbirth,
        email,
        phone,
        gender,
        image,
        pin,
      ];
}
