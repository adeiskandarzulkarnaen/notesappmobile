
class Note {
  late int? id;
  late String title;
  late String description;
  late DateTime updatedAt;

  Note({
    this.id,
    required this.title,
    required this.description,
    required this.updatedAt
  });

  // Factory method to create Note from Map
  factory Note.fromMap(Map<String, dynamic>map) {
    return Note(
      id: map["id"],
      title: map["title"],
      description: map["description"],
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map["updated_at"]), // Convert int to DateTime
    );
  }

  // Method to convert Note to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'updated_at': updatedAt.millisecondsSinceEpoch, // Convert DateTime to int
    };
  }
}
