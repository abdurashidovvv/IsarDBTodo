import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_isar/models/note.dart';
import 'package:todo_isar/models/note_database.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final textEditController = TextEditingController();

  void createNote() {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            content: TextField(
              controller: textEditController,
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  context.read<NoteDatabase>().addNote(textEditController.text);
                  Navigator.pop(context);
                },
                child: const Text("Create"),
              )
            ],
          ),
    );
  }

  void readNotes() {
    context.watch<NoteDatabase>().fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();
    List<Note> currentNotes = noteDatabase.currentNotes;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final note = currentNotes[index];

          return ListTile(
            title: Text(note.text),
          );
        },
      ),
    );
  }
}
