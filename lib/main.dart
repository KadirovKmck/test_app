import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/utils/injector.dart';
import 'presentation/screens/home_screen.dart';
import 'data/models/note_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>('notes');
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog Journal',
      theme: ThemeData(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
