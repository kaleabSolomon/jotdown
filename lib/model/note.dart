class Note {
  String title;
  String content;
  DateTime createdAt;

  Note({required this.title, required this.content, required this.createdAt});

  factory Note.fromMap(Map notes) {
    return Note(
        title: notes["title"],
        content: notes['content'],
        createdAt: notes['createdAt']);
  }

  Map toMap() {
    return {"title": title, "content": content, "createdAt": createdAt};
  }
}
