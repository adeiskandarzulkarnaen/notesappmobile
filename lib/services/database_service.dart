
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note.dart';


class DatabaseService {
  Database? _database;

  // Getter untuk mengambil instance database
  Future<Database?> get database async {
    if (_database != null) return _database; 
    _database = await initDB();
    return _database;
  }

  // Method untuk inisialisasi database
  Future<Database> initDB() async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    final path = '${appDocumentsDir.path}/notesapp.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            updated_at INTEGER
          )
        ''');
      },
    );
  }

  // Method untuk menambahkan catatan ke database
  Future<int> addNote(Note note) async {
    int updatedAt = note.updatedAt.millisecondsSinceEpoch;
     
    final db = await database;
    return await db!.rawInsert(
      "INSERT INTO notes(title, description, updated_at) VALUES(?, ?, ?)",
      [note.title, note.description, updatedAt]
    );
  }

  // Method untuk memperbarui catatan di database
  Future<int> updateNote(Note note) async {
    int updatedAt = note.updatedAt.millisecondsSinceEpoch;
     
    final db = await database;
    return await db!.rawUpdate(
      "UPDATE notes SET title = ?, description = ?, updated_at = ? WHERE id = ?",
      [note.title, note.description, updatedAt, note.id]
    );
  }

  // Method untuk menghapus catatan dari database
  Future<int> deleteNote(int noteId) async {
    final db = await database;
    return await db!.rawDelete(
      "DELETE FROM notes WHERE id = ?",
      [noteId],
    );
  }

  // Method untuk mengambil semua catatan dari database
  Future<List<Note>?> getNotes() async {
    final db = await database;
    List notes =  await db!.rawQuery("SELECT * from notes ORDER BY updated_at DESC");
    
    if (notes.isEmpty) return null;
    final listOfNoteModel = List.generate(
      notes.length, 
      (index) => Note.fromMap(notes[index])
    );
    
    return listOfNoteModel;
  }
}