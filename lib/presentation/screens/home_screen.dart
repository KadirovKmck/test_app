import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/note_model.dart';
import 'new_note_screen.dart';
import 'dart:io';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notesBox = Hive.box<NoteModel>('notes');
    return Scaffold(
      appBar: AppBar(title: const Text('Dog Journal')),
      body: ValueListenableBuilder(
        valueListenable: notesBox.listenable(),
        builder: (_, Box<NoteModel> box, __) {
          if (box.values.isEmpty) {
            return const Center(child: Text('No notes yet'));
          }
          return ListView(
            children: box.values.map((note) {
              return ListTile(
                leading: Image.file(File(note.imagePath), width: 50, height: 50, fit: BoxFit.cover),
                title: Text(note.title),
                subtitle: Text(note.comment, maxLines: 1, overflow: TextOverflow.ellipsis),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const NewNoteScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}