import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:note_app/constants.dart';
import 'package:note_app/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/widgets/custom_button.dart';
import 'package:note_app/widgets/custom_text_field.dart';
import 'package:note_app/widgets/add_note_color_picker.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({super.key});

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? title, content;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          const SizedBox(height: 30),
          CustomTextField(
            onsaved: (value) {
              title = value;
            },
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
            onsaved: (value) {
              content = value;
            },
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
          const SizedBox(height: 50),
          const AddNoteColorPicker(),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<AddNoteCubit, AddNoteState>(
            builder: (context, state) {
              return CustomButton(
                isLoading: state is AddNoteLoading ? true : false,
                text: const Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  noteValidation(context);
                },
                color: kpimaryColor,
              );
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  void noteValidation(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var currentDate = DateTime.now();
      var formattedDate = DateFormat.yMMMEd().format(currentDate);
      var note = NoteModel(
        title: title!,
        content: content!,
        color: Colors.amber.value,
        date: formattedDate,
      );
      BlocProvider.of<AddNoteCubit>(context).addNote(note);
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  OutlineInputBorder buildBorder([color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color ?? Colors.white),
    );
  }
}
