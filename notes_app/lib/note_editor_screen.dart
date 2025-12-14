import 'package:flutter/material.dart';
import 'package:notes_app/note_logic.dart';

class NoteEditorScreen extends StatefulWidget {
  final NoteLogic noteLogic;
  final String? title, content;
  const NoteEditorScreen({
    super.key,
    required this.noteLogic,
    this.title,
    this.content,
  });

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  String? titleError;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    contentController = TextEditingController(text: widget.content);
  }

  // NoteLogic notes = NoteLogic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                "Add your note",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              TextField(
                controller: titleController,
                onChanged: (_) {
                  setState(() {
                    titleError = null;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  hintText: "Enter title",
                  errorText: titleError,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: TextField(
                  controller: contentController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your note content",
                    focusedBorder: OutlineInputBorder(),
                  ),
                  expands: true,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text.isEmpty) {
                    setState(() {
                      titleError = 'Please enter title';
                    });
                    return;
                  } else {
                    widget.noteLogic.addNotes(
                      titleController.text,
                      contentController.text,
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text("Save", style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addNotesToList(String title, String content) {}
}
