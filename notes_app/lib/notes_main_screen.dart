import 'package:flutter/material.dart';
import 'package:notes_app/note_editor_screen.dart';
import 'package:notes_app/note_logic.dart';

class NotesMainScreen extends StatefulWidget {
  const NotesMainScreen({super.key});

  @override
  State<NotesMainScreen> createState() => _NotesMainScreenState();
}

class _NotesMainScreenState extends State<NotesMainScreen> {
  NoteLogic noteLogic = NoteLogic();

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
            MaterialPageRoute(
              builder: (context) => NoteEditorScreen(noteLogic: noteLogic),
            ),
          ).then((_) {
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: noteLogic.notes.isEmpty
            ? Text("No notes yet!", style: TextStyle(fontSize: 20))
            : ListView.builder(
                itemCount: noteLogic.notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(noteLogic.notes[index].title),
                    subtitle: Text(noteLogic.notes[index].content),
                  );
                },
              ),
      ),
    );
  }
}
