class Favorite {
  String? idFavorite;
  String? idUser;
  String? idProduct;

  Favorite({this.idFavorite, this.idUser, this.idProduct});

  Favorite.fromJson(Map<String, dynamic> json) {
    idFavorite = json['idFavorite'];
    idUser = json['idUser'];
    idProduct = json['idProduct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['idFavorite'] = this.idFavorite;
    data['idUser'] = this.idUser;
    data['idProduct'] = this.idProduct;
    return data;
  }
}
