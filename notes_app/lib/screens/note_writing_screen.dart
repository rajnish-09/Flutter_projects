import 'package:flutter/material.dart';
import 'package:notes_app/database/note_database.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/screens/note_home_screen.dart';

class NoteWritingScreen extends StatefulWidget {
  const NoteWritingScreen({super.key});

  @override
  State<NoteWritingScreen> createState() => _NoteWritingScreenState();
}

class _NoteWritingScreenState extends State<NoteWritingScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  NoteDatabase noteDatabase = NoteDatabase();

  String? titleErrorMessage;

  Future<void> createNote() async {
    final title = titleController.text;
    final description = descriptionController.text;
    if (title.isEmpty && description.isEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NoteHomeScreen()),
      );
    } else if (title.isEmpty && description.isNotEmpty) {
      setState(() {
        titleErrorMessage = 'Title is required';
      });
    } else {
      final note = NoteModel(title: title, description: description);
      await noteDatabase.insertNote(note);
      if (!mounted) return;
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
          color: const Color.fromARGB(255, 203, 203, 203),
          style: IconButton.styleFrom(
            backgroundColor: const Color.fromARGB(64, 158, 158, 158),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              createNote();
            },
            icon: Icon(Icons.check),
            color: const Color.fromARGB(255, 203, 203, 203),
            style: IconButton.styleFrom(
              backgroundColor: const Color.fromARGB(150, 255, 193, 7),
            ),
          ),
        ],
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Enter title',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorText: titleErrorMessage,
                  errorBorder: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    titleErrorMessage = null;
                  });
                },
                style: TextStyle(
                  color: const Color.fromARGB(255, 208, 205, 205),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: descriptionController,
                  expands: true,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Enter description',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: const Color.fromARGB(255, 208, 205, 205),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
