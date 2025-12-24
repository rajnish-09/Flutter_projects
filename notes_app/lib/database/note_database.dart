import 'package:notes_app/database/database.dart';
import 'package:notes_app/models/note_model.dart';

class NoteDatabase {
  final db = DBHelper.instance;

  Future<int> insertNote(NoteModel note) async {
    final database = await db.database;
    return database.insert(NoteModel.tableName, note.toJson());
  }

  Future<List<NoteModel>> fetchNote() async {
    final database = await db.database;
    final List<Map<String, dynamic>> data = await database.query(
      NoteModel.tableName,
    );
    return data.map((e) => NoteModel.fromJson(e)).toList();
  }

  Future<int> deleteNote(int id) async {
    final database = await db.database;
    return database.delete(NoteModel.tableName, where: 'id=?', whereArgs: [id]);
  }

  Future<int> updateNote(NoteModel note) async {
    final database = await db.database;
    return database.update(
      NoteModel.tableName,
      note.toJson(),
      where: 'id=?',
      whereArgs: [note.id],
    );
  }
}
