import 'package:dio/dio.dart';
import 'package:flutter_application/note_model.dart';

class ResponseModel {
  final Dio dio = Dio();

  String notesApiUrl =
      'https://6582b34702f747c83679f13c.mockapi.io/notes/1/notes';

  List<Note> notes = [];

  Future<List<Note>> getNotes() async {
    try {
      final response = (await dio.get(notesApiUrl));
      List<dynamic> responseData = response.data;

      notes = responseData.map((data) {
        return Note.fromJson(data);
      }).toList();
    } catch (e) {
      print('Error fetching notes:');
    }
    return notes;
  }

  Future<void> postNote(Note newNote) async {
    try {
      await dio.post(notesApiUrl, data: {
        'title': newNote.title,
        'content': newNote.content,
        'dateTime': newNote.dateTime?.millisecondsSinceEpoch,
      });

      getNotes();
    } catch (e) {
      print('Error adding note:');
    }
  }

  Future<void> updateNote(Note updatedNote) async {
    try {
      await dio.put("$notesApiUrl/${updatedNote.id}", data: {
        'title': updatedNote.title,
        'content': updatedNote.content,
        'dateTime': updatedNote.dateTime?.millisecondsSinceEpoch,
      });

      getNotes();
    } catch (e) {
      print('Error updating note:');
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await dio.delete('$notesApiUrl/$noteId');
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Note deleted'),
      //     duration: Duration(seconds: 2),
      //   ),
      // );
      getNotes();
    } catch (e) {
      print('Error deleting note');
    }
  }
}
