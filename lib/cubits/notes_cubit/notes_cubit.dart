import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:note_app/constants.dart';
import 'package:note_app/models/note_model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());
  
List<NoteModel>? notesList ;

  fetchAllNotes(){
   
  var notesBox = Hive.box<NoteModel>(kNotesBox);
    notesList=notesBox.values.toList();
  emit(NotesSuccess());

 
  }

  deleteAllNotes() {
    var notesBox = Hive.box<NoteModel>(kNotesBox);
    notesBox.clear();
    notesList?.clear();
    emit(NotesDeleted());
  }
}
