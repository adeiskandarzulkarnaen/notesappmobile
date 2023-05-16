import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:notes_app/models/notes.dart';

class DatabaseService{
  DatabaseService._();

  static final DatabaseService db = DatabaseService._();

  static Database? _database;
  
  // Create database getter
  Future<Database?> get database async {
    // check database availbilty
    if(_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'notes.db'),
      version: 1,
      onCreate: (db, version) async {
        // create first table
        db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT, 
            description TEXT,
            createdAt DATE
          )
        ''');
      },
    );
  }

  // Add Note From note model
  addNewNote(Note note) async {
    final db = await database;
    db!.insert(
      'notes', 
      note.toMap(), 
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  // Get All Note
  Future getNotes() async {
    final db = await database;
    var result = await db!.query('notes');

    if(result.isEmpty) {
      return null;
    } else {
      var lastResult = result.toList();
      return lastResult.isNotEmpty ? lastResult : null;
    }
  }

  // Edit Note
  Future<int> updateNote(Note note) async{
    final db = await database;
    var result = await db!.rawUpdate('''
      UPDATE notes 
      SET title="${note.title}", description="${note.description}"
      WHERE id=${note.id}
    ''');
    return result;
  }

  //  Mneghapus Note 
  Future<int> deleteNote(int id) async {
    final db = await database;
    int count = await db!.rawDelete(
      'DELETE FROM notes WHERE id = ?',
      [id],
    );
    return count;
  }
}

