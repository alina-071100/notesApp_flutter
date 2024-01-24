part of 'note_bloc.dart';



abstract class NotesState {}

class NotesInitialState extends NotesState {}

class NotesLoadingState extends NotesState {}

class NotesLoadedState extends NotesState {
  final List<Note> notes;

  NotesLoadedState(this.notes);
}

class NotesErrorState extends NotesState {
  final String errorMessage;

  NotesErrorState(this.errorMessage);
}


