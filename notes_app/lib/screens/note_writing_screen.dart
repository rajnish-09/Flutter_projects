import 'package:flutter/material.dart';
import 'package:notes_app/database/note_database.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/screens/note_home_screen.dart';

class NoteWritingScreen extends StatefulWidget {
  final NoteModel? note;
  const NoteWritingScreen({super.key, this.note});

  @override
  State<NoteWritingScreen> createState() => _NoteWritingScreenState();
}

class _NoteWritingScreenState extends State<NoteWritingScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  NoteDatabase noteDatabase = NoteDatabase();

  String? titleErrorMessage;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note?.title ?? '');
    descriptionController = TextEditingController(
      text: widget.note?.description ?? '',
    );
  }

  Future<void> createNote() async {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
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

  void updateNote() async {
    if (widget.note == null) return;
    final updatedNote = NoteModel(
      id: widget.note!.id,
      title: titleController.text,
      description: descriptionController.text,
    );
    await noteDatabase.updateNote(updatedNote);
    if (!mounted) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            widget.note == null ? createNote() : updateNote();
          },
          icon: Icon(Icons.arrow_back),
          color: const Color.fromARGB(255, 203, 203, 203),
          style: IconButton.styleFrom(
            backgroundColor: const Color.fromARGB(64, 158, 158, 158),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              widget.note == null ? createNote() : updateNote();
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
