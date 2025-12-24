import 'package:flutter/material.dart';

class NoteWritingScreen extends StatefulWidget {
  const NoteWritingScreen({super.key});

  @override
  State<NoteWritingScreen> createState() => _NoteWritingScreenState();
}

class _NoteWritingScreenState extends State<NoteWritingScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
            onPressed: () {},
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
                ),
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
