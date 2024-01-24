part of 'note_bloc.dart';

abstract class NotesEvent {}
class NoteInitialEvent extends NotesEvent {}


class FetchNotesEvent extends NotesEvent {}

class AddNoteEvent extends NotesEvent {
  final Note newNote;

  AddNoteEvent(this.newNote);
}

class UpdateNoteEvent extends NotesEvent {
  final Note updatedNote;

  UpdateNoteEvent(this.updatedNote);
}

class DeleteNoteEvent extends NotesEvent {
  final String noteId;

  DeleteNoteEvent(this.noteId);
}