import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/views/edit_note_view.dart';

class NotesItem extends StatelessWidget {
  const NotesItem({super.key,required this.note});
 
 final NoteModel note;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Navigator.of(context).push(_createRoute());
      
      },
      child: Container(
        padding: const EdgeInsets.only(
          top: 22,
          left: 16,
          bottom: 22,
        ),
        decoration: BoxDecoration(
          color: Color(note.color),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ListTile(
              title: Text(
                note.title,
                style:  TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.normal,
                  color:getContrastingTextColor(Color(note.color)),
                ),
              ),
              subtitle:  Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: Text(
                  note.content,
                  style: TextStyle(fontSize: 17, color:getContrastingTextColor(Color(note.color))
                  ),
                ),
              ),
              trailing: IconButton(
                padding: const EdgeInsets.only(bottom: 12),
                onPressed: () {
                  note.delete();
                  BlocProvider.of<NotesCubit>(context).fetchAllNotes();
                },
                icon:  Icon(
                  FontAwesomeIcons.trash,
                  color:getContrastingTextColor(Color(note.color)),
                  size: 24,
                ),
              ),
            ),
             Padding(
              padding: EdgeInsets.only(right: 20, top: 10),
              child: Text(
                note.date,
                style: TextStyle(fontSize: 15, color: getContrastingTextColor(Color(note.color))),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => EditNoteView(note: note),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
    const begin = Offset(0.0, 1.0); 
  const end = Offset.zero;  
  const curve = Curves.ease;  

  final tween = Tween(begin: begin, end: end); 
  final curvedAnimation = CurvedAnimation(parent: animation, curve: curve); 

  return SlideTransition( 
    position: tween.animate(curvedAnimation),
    child: child,
  );
    },
  );
}

Color getContrastingTextColor(Color backgroundColor) {
    return backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
