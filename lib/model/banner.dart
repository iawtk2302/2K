import 'package:equatable/equatable.dart';

class CustomBanner extends Equatable {
  final String id;
  final String image;
  const CustomBanner({
    required this.id,
    required this.image,
  });

  @override
  List<Object?> get props => [id, image];
}
