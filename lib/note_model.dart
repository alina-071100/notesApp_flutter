class Note {
  String? id;
  String? title;
  String? content;
  DateTime? dateTime;

  Note({
    this.id,
    this.title,
    this.content,
    this.dateTime,
  });

  factory Note.fromJson(Map<String, dynamic> data) {
    return Note(
      id: data["id"],
      title: data['title'],
      content: data['content'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
    );
  }
}
