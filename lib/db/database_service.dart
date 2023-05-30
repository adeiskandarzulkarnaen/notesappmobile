import 'package:hive/hive.dart';

import '../models/note.dart';

class DatabaseService {
  static const boxName = 'notes';

  Future<void> addNote(Note note) async {
    final box = await Hive.openBox(boxName);
    await box.add(note);
  }

  Future<void> editNote(int key, Note note) async {
    final box = await Hive.openBox(boxName);
    await box.put(key, note);
  }

  Future<List<Note>> getNotes(Note note) async {
    final box = await Hive.openBox(boxName);
    return box.get(note.key);
  }
  
  Future<void> deleteNote(Note note) async {
    final box = await Hive.openBox(boxName);
    await box.delete(note.key);
  }
}