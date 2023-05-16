class Note {
  final int id;
  final String title;
  final String description;
  final DateTime createdAt;

  Note(this.id, this.title, this.description, this.createdAt);

  factory Note.fromMap(Map<String, dynamic> data){
    return Note(
      data["id"],
      data["title"],
      data["description"],
      DateTime.parse(data["createdAt"]),
    );
  }

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "title": title,
      "describe": description,
      "reatedAt": createdAt.toIso8601String(),
    };
  }
}