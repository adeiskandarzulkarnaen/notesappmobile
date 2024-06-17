import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/note.dart';
import 'pages/about_page.dart';
import 'pages/home_page.dart';
import 'pages/addnote_page.dart';
import 'services/database_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ),
  );
  final dbService = DatabaseService();
  runApp(NotesApp(dbService: dbService));
}

class NotesApp extends StatelessWidget {
  final DatabaseService dbService;
  const NotesApp({super.key, required this.dbService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NotesApp',
      theme: ThemeData(
        fontFamily: 'Quicksand',
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/home',
      routes: {
        "/home" : (context) => HomePage(dbService: dbService),
        "/about" : (context) => const AboutPage(),
        "/addnote": (context) => AddNotePage(
          dbService: dbService,
          note: ModalRoute.of(context)?.settings.arguments as Note?,
        ),
      },
    );
  }
}