
import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/note.dart';


class AddNotePage extends StatefulWidget {
  final Note? note;
  final DatabaseService dbService;
  const AddNotePage({super.key, this.note, required this.dbService});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _title;
  late TextEditingController _description;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.note?.title);
    _description = TextEditingController(text: widget.note?.description);
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.note != null ? "Edit Note" : "Add Note",
          style: Theme.of(context)
            .textTheme
            .headlineMedium
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  decoration: InputDecoration(
                    hintText: "title",
                    border: InputBorder.none,
                    hintStyle: Theme.of(context).textTheme.headlineLarge,
                  ),
                  validator: (value) {
                    if (value == "") {
                      return "tite can't null";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _description,
                  maxLines: null,
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: "description",
                    border: InputBorder.none,
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                  validator: (value) {
                    if (value == "") {
                      return "desc can't null";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            
            final note = Note(
              id: widget.note?.id,
              title: _title.text,
              description: _description.text,
              updatedAt: DateTime.now(),
            );
            
            widget.note != null 
              ? await widget.dbService.updateNote(note)
              : await widget.dbService.addNote(note);
            
            if (!context.mounted) return;
            Navigator.of(context).pop();
          }
        },
        label: const Text("Save"),
        icon: const Icon(Icons.save),
      ),
    );
  }
}
