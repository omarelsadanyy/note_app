import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:note_app/constants.dart';
import 'package:note_app/models/note_model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());
static NotesCubit get(context) => BlocProvider.of(context);  
List<NoteModel> notesList =[];
 List<NoteModel> searchedNotes = [];
TextEditingController searchController= TextEditingController(); 

  fetchAllNotes(){
  var notesBox = Hive.box<NoteModel>(kNotesBox);
    notesList=notesBox.values.toList();
  emit(NotesSuccess()); 
  }

  deleteAllNotes() {
    var notesBox = Hive.box<NoteModel>(kNotesBox);
    notesBox.clear();
    notesList.clear();
    emit(NotesDeleted());
  }

  searchNotes(){
   searchedNotes =notesList.where((note)=>note.title.contains(searchController.text)).toList();
    emit(NotesSuccess());
  }
}
