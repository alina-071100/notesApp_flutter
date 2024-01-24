import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/bloc/note_bloc.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/note_model.dart';
import 'package:flutter_application/note_response.dart';
import 'package:flutter_application/notes_from.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Note> notes = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(builder: (context, state) {
      if (state is NotesLoadedState) {
        notes = state.notes;
      } else if (state is NotesErrorState) {
        print("Error: ${state.errorMessage}");
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text('Notes App'),
        ),
        body: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(notes[index].title ?? ""),
              subtitle: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                  ),
                  Expanded(
                    child: Text(
                      notes[index].content ?? "",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(notes[index].dateTime.toString()),
                ],
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext _context) {
                    return AlertDialog(
                      title: const Text('Edit Note'),
                      content: NoteForm(
                        initialNote: notes[index],
                        onSubmit: (Note updatedNote) {
                          BlocProvider.of<NotesBloc>(context)
                              .add(UpdateNoteEvent(updatedNote));
                          Navigator.of(context).pop();
                        },
                      ),
                    );
                  },
                );
              },
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  BlocProvider.of<NotesBloc>(context)
                      .add(DeleteNoteEvent(notes[index].id ?? ""));
                },
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext _context) {
                return AlertDialog(
                  title: const Text('Add Note'),
                  content: NoteForm(
                    onSubmit: (Note newNote) {
                      BlocProvider.of<NotesBloc>(context)
                          .add(AddNoteEvent(newNote));
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
