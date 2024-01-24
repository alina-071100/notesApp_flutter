import 'package:flutter/material.dart';
import 'package:flutter_application/bloc/note_bloc.dart';
import 'package:flutter_application/note_response.dart';
import 'package:flutter_application/note_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

ResponseModel res = ResponseModel();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      home: BlocProvider<NotesBloc>(
        create: (context) => NotesBloc(res),
        child: NotesScreen(),
      ),
    );
  }
}
