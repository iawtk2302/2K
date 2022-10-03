class Category {
  String? idCategory;
  String? idBrand;
  String? name;

  Category({this.idCategory, this.idBrand, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    idCategory = json['idCategory'];
    idBrand = json['idBrand'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idCategory'] = this.idCategory;
    data['idBrand'] = this.idBrand;
    data['name'] = this.name;
    return data;
  }
}
