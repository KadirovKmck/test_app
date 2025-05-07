import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/note_model.dart';

class NewNoteScreen extends StatefulWidget {
  const NewNoteScreen({super.key});

  @override
  State<NewNoteScreen> createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  final titleController = TextEditingController();
  final commentController = TextEditingController();
  File? imageFile;

  Future pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  void saveNote() {
    if (titleController.text.isEmpty || commentController.text.isEmpty || imageFile == null) return;
    final note = NoteModel(
      id: const Uuid().v4(),
      title: titleController.text,
      comment: commentController.text,
      imagePath: imageFile!.path,
    );
    Hive.box<NoteModel>('notes').add(note);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Note')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: commentController, decoration: const InputDecoration(labelText: 'Comment')),
            const SizedBox(height: 10),
            imageFile != null
                ? Image.file(imageFile!, height: 150)
                : const Text('No image selected'),
            ElevatedButton(onPressed: pickImage, child: const Text('Pick Image')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: saveNote, child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}