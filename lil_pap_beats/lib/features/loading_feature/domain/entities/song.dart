import 'package:equatable/equatable.dart';

class Song extends Equatable {
  final String title;
  final String fileType;

  const Song({
    required this.title,
    required this.fileType,
  });

  String toJson() {
    return '$title.$fileType';
  }

  @override
  List<Object> get props => [title, fileType];
}
