import "package:hive/hive.dart";

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  late String title;
  @HiveField(1)
  late String content;
  @HiveField(2)
  late DateTime createdAt;

  Note({required this.title, required this.content, required this.createdAt});

  factory Note.fromMap(Map notes) {
    return Note(
      title: notes["title"] ?? "",
      content: notes['content'] ?? "",
      createdAt:
          DateTime.parse(notes['createdAt'] ?? DateTime.now().toString()),
    );
  }

  Map toMap() {
    return {"title": title, "content": content, "createdAt": createdAt};
  }

  @override
  String toString() {
    return "\n  title: $title,\n  content: $content,\n  createdAt: $createdAt";
  }
}
