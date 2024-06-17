
import 'package:flutter/material.dart';
import 'package:notesappflutter/services/database_service.dart';
import '../models/note.dart';
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
      appBar: AppBar(
        toolbarHeight: 100,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Notes",
                  style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    " app",
                    style: Theme.of(context)
                      .textTheme
                      .bodyMedium,
                  ),
                ),
              ],
            ),
            Text(
              " Safeguard Your Ideas with NotesApp",
              style: Theme.of(context)
                .textTheme
                .bodyMedium,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/about');
            },
            iconSize: 28.0,
            padding: const EdgeInsets.all(8),
            icon: const Icon(Icons.info_outline),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: FutureBuilder(
        future: widget.dbService.getNotes(), 
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if(snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if(snapshot.hasData && snapshot.data != null) {
            List<Note> listOfNote = snapshot.data!;
            return ListView.builder(
              itemCount: listOfNote.length,
              itemBuilder: (context, index) {
                return NoteCard(
                  note: listOfNote[index],
                  dbService: widget.dbService,
                );
              },
            );
          } else {
            return const Center(child: Text("No Data"));
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
}
