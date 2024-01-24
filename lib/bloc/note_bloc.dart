import 'package:bloc/bloc.dart';
import 'package:flutter_application/note_model.dart';
import 'package:flutter_application/note_response.dart';

part 'note_event.dart';
part 'note_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final ResponseModel response;

  NotesBloc(this.response) : super(NotesInitialState()) {
    on<FetchNotesEvent>(mapFetchNotesToState);
    on<AddNoteEvent>(mapAddNoteToState);
    on<UpdateNoteEvent>(mapUpdateNoteToState);
    on<DeleteNoteEvent>(mapDeleteNoteToState);

    add(FetchNotesEvent());
  }

  Future<void> mapFetchNotesToState(
      FetchNotesEvent event, Emitter<NotesState> emit) async {
    try {
      List<Note> notes = await response.getNotes();
      print(notes);
      emit(NotesLoadedState(notes));
    } catch (e) {
      emit(NotesErrorState("Error fetching notes"));
    }
  }

  Future<void> mapAddNoteToState(
      AddNoteEvent event, Emitter<NotesState> emit) async {
    try {
      await response.postNote(event.newNote);
      List<Note> notes = await response.getNotes();
      emit(NotesLoadedState(notes));
    } catch (e) {
      emit(NotesErrorState("Error adding note"));
    }
  }

  Future<void> mapUpdateNoteToState(
      UpdateNoteEvent event, Emitter<NotesState> emit) async {
    try {
      await response.updateNote(event.updatedNote);
      List<Note> notes = await response.getNotes();
      emit(NotesLoadedState(notes));
    } catch (e) {
      emit(NotesErrorState("Error updating note"));
    }
  }

  Future<void> mapDeleteNoteToState(
      DeleteNoteEvent event, Emitter<NotesState> emit) async {
    try {
      await response.deleteNote(event.noteId);
      List<Note> notes = await response.getNotes();
      emit(NotesLoadedState(notes));
    } catch (e) {
      emit(NotesErrorState("Error deleting note"));
    }
  }
}
