import 'package:flutter/material.dart';
import 'package:notes_app/note_editor_screen.dart';

class NotesMainScreen extends StatefulWidget {
  const NotesMainScreen({super.key});

  @override
  State<NotesMainScreen> createState() => _NotesMainScreenState();
}

class _NotesMainScreenState extends State<NotesMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.note),
        title: Text(
          "Notes",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteEditorScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
