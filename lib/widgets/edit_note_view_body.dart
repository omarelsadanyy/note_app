import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/constants.dart';
import 'package:note_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/widgets/custom_app_bar.dart';
import 'package:note_app/widgets/custom_text_field.dart';

import 'package:note_app/widgets/edit_note_color_picker.dart';

class EditNoteViewBody extends StatefulWidget {
  const EditNoteViewBody({super.key, required this.note});
  final NoteModel note;

  @override
  State<EditNoteViewBody> createState() => _EditNoteViewBodyState();
}

class _EditNoteViewBodyState extends State<EditNoteViewBody> {
  String? title, content;
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 50),
          CustomAppBar(
            text: 'Edit Note',
            icon: FontAwesomeIcons.check,
            onPressed: () {
              widget.note.title = _titleController.text;
              widget.note.content = _contentController.text;
              widget.note.save();
              BlocProvider.of<NotesCubit>(context).fetchAllNotes();
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 50),
          CustomTextField(
            controller: _titleController,
            cursorColor: (kpimaryColor),
            decoration: InputDecoration(
              hintText: 'Title',
              hintStyle: const TextStyle(color: kpimaryColor),
              border: buildBorder(),
              enabledBorder: buildBorder(),
              focusedBorder: buildBorder(kpimaryColor),
            ),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _contentController,
            cursorColor: (kpimaryColor),
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Content',
              hintStyle: const TextStyle(color: kpimaryColor),
              border: buildBorder(),
              enabledBorder: buildBorder(),
              focusedBorder: buildBorder(kpimaryColor),
            ),
          ),
          const SizedBox(height: 20),
          EditNoteColorPicker(note: widget.note),
        ],
      ),
    );
  }

  OutlineInputBorder buildBorder([color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color ?? Colors.white),
    );
  }
}
