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
  @HiveField(3)
  late bool isPrivate;

  Note(
      {required this.title,
      required this.content,
      required this.createdAt,
      required this.isPrivate});

  factory Note.fromMap(Map notes) {
    return Note(
        title: notes["title"] ?? "",
        content: notes['content'] ?? "",
        createdAt:
            DateTime.parse(notes['createdAt'] ?? DateTime.now().toString()),
        isPrivate: notes['isPrivate'] ?? "");
  }

  Map toMap() {
    return {
      "title": title,
      "content": content,
      "createdAt": createdAt,
      "isPrivate": isPrivate
    };
  }

  @override
  String toString() {
    return "\n  title: $title,\n  content: $content,\n  createdAt: $createdAt, \n isPrivate:$isPrivate";
  }
}
