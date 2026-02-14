import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:notes_app/database/note_database.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/screens/note_writing_screen.dart';
// import 'package:google_fonts/google_fonts.dart';

class NoteHomeScreen extends StatefulWidget {
  const NoteHomeScreen({super.key});

  @override
  State<NoteHomeScreen> createState() => _NoteHomeScreenState();
}

class _NoteHomeScreenState extends State<NoteHomeScreen> {
  NoteDatabase noteDatabase = NoteDatabase();

  List<NoteModel> notes = [];

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  void fetchNotes() async {
    notes = await noteDatabase.fetchNote();
    setState(() {});
  }

  void deleteData(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          title: Text(
            "Are you sure you want to delete?",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                final noteId = notes[index].id;
                if (noteId == null) return;
                final res = await noteDatabase.deleteNote(noteId);
                if (res > 0) {
                  print('delete');
                  Navigator.pop(context);
                  notes = await noteDatabase.fetchNote();
                  setState(() {});
                }
              },
              child: Text("Yes"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("No"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteWritingScreen()),
          );
          if (result == true) {
            notes = await noteDatabase.fetchNote();
            setState(() {});
          }
        },
        shape: CircleBorder(),
        backgroundColor: const Color.fromARGB(133, 158, 158, 158),
        child: Icon(Icons.note_alt_outlined, color: Colors.white),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            final data = await noteDatabase.fetchNote();
            setState(() {
              notes = data;
            });
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  notes.isEmpty ? 'Empty Notes' : '${notes.length} Notes',
                  style: TextStyle(
                    fontSize: 15,
                    color: const Color.fromARGB(255, 110, 110, 110),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 10);
                    },
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final data = notes[index];
                      return GestureDetector(
                        onTap: () async {
                          final res = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NoteWritingScreen(note: data),
                            ),
                          );
                          if (res == true) {
                            notes = await noteDatabase.fetchNote();
                            setState(() {});
                          }
                        },
                        child: Container(
                          // height: 100,
                          // width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFF1c1c1e),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.title,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat-Bold',
                                        ),
                                      ),
                                      Text(
                                        data.description,
                                        style: TextStyle(color: Colors.white),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    deleteData(index);
                                  },
                                  icon: Icon(Icons.delete, color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                // ElevatedButton(onPressed: () {}, child: Text("Nothing")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
