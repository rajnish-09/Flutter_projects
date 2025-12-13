class Note {
  String title, content;

  Note({required this.title, required this.content});
}

class NoteLogic {
  int currentIndex = 0;
  List<Note> notes = [];

  void addNotes(String noteTitle, String noteContent) {
    notes.add(Note(title: noteTitle, content: noteContent));
  }

  String getTitle() {
    return notes[currentIndex].title;
  }

  String getContent() {
    return notes[currentIndex].content;
  }
}
