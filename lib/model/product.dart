import 'package:equatable/equatable.dart';

class Product extends Equatable {
  String? idProduct;
  String? idCategory;
  String? name;
  double? price;
  List<dynamic>? image;
  String? description;
  List<dynamic>? gender;
  String? categoryName;

  Product(
      {this.idProduct,
      this.idCategory,
      this.name,
      this.price,
      this.image,
      this.description,
      this.gender,
      this.categoryName});

  Product.fromJson(Map<String, dynamic> json) {
    idProduct = json['idProduct'];
    idCategory = json['idCategory'];
    name = json['name'];
    price = double.tryParse(json['price'].toString());
    image = json['image'];
    description = json['description'];
    gender = json['gender'];
    categoryName = json['categoryName'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idProduct'] = this.idProduct;
    data['idCategory'] = this.idCategory;
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    data['description'] = this.description;
    data['gender'] = this.gender;
    data['categoryName'] = this.categoryName;
    return data;
  }

  @override
  List<Object?> get props => [
        idProduct,
        idCategory,
        name,
        price,
        image,
        description,
        gender,
        categoryName
      ];
}
