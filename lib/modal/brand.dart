import 'package:equatable/equatable.dart';

class Brand extends Equatable {
  String? id;
  String? name;
  String? imageUrl;

  Brand({required this.id, required this.name, required this.imageUrl});
  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
  }

  @override
  List<Object?> get props => [id, name, imageUrl];
}
