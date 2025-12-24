import 'package:notes_app/models/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._internal();
  static Database? _db;
  DBHelper._internal();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'noteDatabase.db');
    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    return db.execute(NoteModel.createNoteTable);
  }
}
