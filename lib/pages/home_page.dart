import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/utils/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes App"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          GoRouter.of(context).goNamed(
            AppRoutes.addNote
          );
        },
        child: const Icon(
          Icons.note_add_rounded,
        ),
      ),
      body: Column(
        children: const [
          NoteCard(),
          NoteCard(),
        ]
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 4
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        // border: Border.all(color: Colors.black),
        color: Colors.white,
      ),
      child: ListTile(
        onTap: (){},
        title: Text(
          "Judul Catatan",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text("Deskripsi"),
        trailing: Text("Dibuat pada: \n20-12-2022"),
      ),
    );
  }
}