import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/widgets/notes_item.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        if (state is NotesDeleted) {
          return const Center(
            child: Text(
              'No notes available.',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          );
        }

        if (state is NotesInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is NotesSuccess) {
          List<NoteModel> notesList = BlocProvider.of<NotesCubit>(context).notesList ?? []; 

          
          if (notesList.isEmpty) {
            return const Center(
              child: Text(
                'No notes available.',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: NotesItem(note: notesList[index]),
                );
              },
            ),
          );
        }

        return const Center(child: CircularProgressIndicator()); // Fallback if no state matches
      },
    );
  }
}
