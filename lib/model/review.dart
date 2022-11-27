import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Review extends Equatable {
  String? content;
  String? idProduct;
  String? idReview;
  String? idUser;
  String? fullName;
  int? star;
  String? image;
  Timestamp? dateCreated;

  Review(
      {this.content,
      this.idProduct,
      this.idReview,
      this.idUser,
      this.fullName,
      this.star,
      this.image,
      this.dateCreated});

  Review.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    idProduct = json['idProduct'];
    idReview = json['idReview'];
    idUser = json['idUser'];
    fullName = json['fullName'];
    star = json['star']+1;
    image = json['image'];
    dateCreated = json['dateCreated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['idProduct'] = this.idProduct;
    data['idReview'] = this.idReview;
    data['idUser'] = this.idUser;
    data['fullName'] = this.fullName;
    data['star'] = this.star;
    data['image'] = this.image;
    data['dateCreated'] = this.dateCreated;
    return data;
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [];
}