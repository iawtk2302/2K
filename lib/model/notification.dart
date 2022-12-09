class NotificationCustom {
  String? idNotification;
  String? title;
  String? body;
  String? image;

  NotificationCustom({this.idNotification, this.title, this.body, this.image});

  NotificationCustom.fromJson(Map<String, dynamic> json) {
    idNotification = json['idNotification'];
    title = json['title'];
    body = json['body'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idNotification'] = this.idNotification;
    data['title'] = this.title;
    data['body'] = this.body;
    data['image'] = this.image;
    return data;
  }
}