
import 'package:flutter/material.dart';

import '../../extentions/format_date.dart';
import '../../models/note.dart';
import '../../services/database_service.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final DatabaseService dbService;
  final VoidCallback? onUpdateCallback;

  const NoteCard({
    super.key,
    required this.note,
    required this.dbService,
    this.onUpdateCallback
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(note.id.toString()),
      confirmDismiss: (direction) => _confirmDismiss(context),
      onDismissed: (direction) async {
        await dbService.deleteNote(note.id!);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          // border: Border.all(color: Colors.black),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: ListTile(
          onTap: () async {
            await Navigator.pushNamed(context, '/addnote', arguments: note);
            if (onUpdateCallback != null) onUpdateCallback!();
          },
          title: Text(
            note.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            note.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(note.updatedAt.formatDate()),
        ),
      ),
    );
  }

  Future<bool?> _confirmDismiss(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: const Text("Are you sure you want to delete this note?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
