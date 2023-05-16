import 'package:flutter/material.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late TextEditingController _title;
  late TextEditingController _description;
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    _title = TextEditingController();
    _description = TextEditingController();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Note"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric( horizontal: 16 ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _title,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    ),
                  decoration: const InputDecoration(
                    hintText: "title",
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  validator: (value) {
                    if (value == ""){
                      return "tite can't null";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _description,
                  maxLines: null,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    ),
                  decoration: const InputDecoration(
                    hintText: "description",
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      fontSize:14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  validator: (value) {
                    if (value == ""){
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
        onPressed: (){},
        label: const Text("Save"),
        icon: const Icon(Icons.save),
      ),
    );
  }
}