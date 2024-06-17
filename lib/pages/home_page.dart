
import 'package:flutter/material.dart';

import '../models/note.dart';
import '../services/database_service.dart';
import 'fragments/custom_appbar.dart';
import 'fragments/note_card.dart';

class HomePage extends StatefulWidget {
  final DatabaseService dbService;
  const HomePage({super.key, required this.dbService});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: FutureBuilder(
        future: widget.dbService.getNotes(), 
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if(snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if(snapshot.hasData && snapshot.data != null) {
            return noteCardBuilder(snapshot.data!);
          } else {
            return const Center(child: Text("Nothing Notes"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.pushNamed(context, '/addnote');
          setState(() { });
        }, 
        label: const Text("Add Note"),
        icon: const Icon(Icons.note_add_rounded),
      ),
    );
  }

  Widget noteCardBuilder(List<Note> notes) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return NoteCard(
          note: notes[index],
          dbService: widget.dbService,
          onUpdateCallback: () => setState((){}),
        );
      },
    );
  }
}

