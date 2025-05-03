import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:note_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:note_app/widgets/add_note_bottom_sheet.dart';
import 'package:note_app/widgets/notes_view_body.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        elevation: 0,
        overlayColor: Colors.black,
        childPadding: const EdgeInsets.all(4),
        backgroundColor: Colors.cyanAccent,
        activeIcon: Icons.close,
        iconTheme: const IconThemeData(color: Colors.black),
        buttonSize: const Size(68, 68),
        curve: Curves.bounceInOut,
        children: [
          SpeedDialChild(
            shape: const OvalBorder(),
            backgroundColor: Colors.white,
            child: const Icon(Icons.add, color: Colors.cyanAccent),
            labelWidget: const Text(
              'Add Note ',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                context: context,
                builder: (context) {
                  return const AddNoteBottomSheet();
                },
              );
            },
          ),
          SpeedDialChild(
            shape: const OvalBorder(),
            backgroundColor: Colors.white,
            child: const Icon(Icons.delete, color: Colors.cyanAccent),
            labelWidget: const Text(
              'Delete All Note ',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            onTap: () {
             // context.read<NotesCubit>().deleteAllNotes();
              BlocProvider.of<NotesCubit>(context).deleteAllNotes();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All notes deleted')),
              );
            },
          ),
        ],
        child: const Icon(Icons.more_vert, color: Colors.black),
      ),
      body: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          return const NotesViewBody();
        },
      ),
    );
  }
}
