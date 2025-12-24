import 'package:flutter/material.dart';
import 'package:notes_app/screens/note_writing_screen.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NoteHomeScreen extends StatefulWidget {
  const NoteHomeScreen({super.key});

  @override
  State<NoteHomeScreen> createState() => _NoteHomeScreenState();
}

class _NoteHomeScreenState extends State<NoteHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteWritingScreen()),
          );
        },
        shape: CircleBorder(),
        backgroundColor: const Color.fromARGB(133, 158, 158, 158),
        child: Icon(Icons.note_alt_outlined, color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                "Notes",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "6 Notes",
                style: TextStyle(
                  fontSize: 15,
                  color: const Color.fromARGB(255, 110, 110, 110),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
