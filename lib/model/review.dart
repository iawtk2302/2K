class Review {
  String? content;
  String? idProduct;
  String? idReview;
  int? star;

  Review({this.content, this.idProduct, this.idReview, this.star});

  Review.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    idProduct = json['idProduct'];
    idReview = json['idReview'];
    star = json['star'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['idProduct'] = this.idProduct;
    data['idReview'] = this.idReview;
    data['star'] = this.star;
    return data;
  }
}
