class Product {
  String? idCategory;
  String? name;
  String? price;
  List<dynamic>? image;
  String? description;
  List<dynamic>? gender;

  Product(
      {this.idCategory,
      this.name,
      this.price,
      this.image,
      this.description,
      this.gender});

  Product.fromJson(Map<String, dynamic> json) {
    idCategory = json['idCatagory'];
    name = json['name '];
    price = json['price'];
    image = json['image'];
    description = json['description'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idCatagory'] = this.idCategory;
    data['name '] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    data['description'] = this.description;
    data['gender'] = this.gender;
    return data;
  }
}
