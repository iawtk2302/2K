import 'package:equatable/equatable.dart';

class Banner extends Equatable {
  final String id;
  final int percent;
  final String title;
  final String content;
  final String image;
  Banner(
      {required this.id,
      required this.image,
      required this.percent,
      required this.title,
      required this.content});

  @override
  List<Object?> get props => [id, percent, title, content, image];
}
