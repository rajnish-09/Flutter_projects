class NoteModel {
  final int? id;
  final String title;
  final String description;

  NoteModel({this.id, required this.title, required this.description});

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
  };

  static const tableName = 'notes';
  static const createNoteTable =
      'CREATE TABLE $tableName (id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT)';
}
