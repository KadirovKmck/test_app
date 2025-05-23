import 'package:hive/hive.dart';
part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String comment;
  @HiveField(3)
  final String imagePath;

  NoteModel({
    required this.id,
    required this.title,
    required this.comment,
    required this.imagePath,
  });
}