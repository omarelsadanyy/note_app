import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/widgets/custom_button.dart';

class EditNoteColorPicker extends StatefulWidget {
  const EditNoteColorPicker({super.key, required this.note});
  final NoteModel note;
  @override
  State<EditNoteColorPicker> createState() => _EditNoteColorPickerState();
}

class _EditNoteColorPickerState extends State<EditNoteColorPicker> {
  Color selectedColor = Colors.amber;
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      height: 50,
      width: 150,
      onTap: () {
        ColorPicker(
          color: selectedColor,
          onColorChanged: (value) {
            setState(() {
              selectedColor = value;
              widget.note.color = selectedColor.toARGB32();
            });
          },
          pickersEnabled: const <ColorPickerType, bool>{
            ColorPickerType.wheel: true,
            ColorPickerType.primary: true,
            ColorPickerType.accent: true,
            ColorPickerType.bw: false,
            ColorPickerType.custom: false,
          },
        ).showPickerDialog(context);
      },
      text: const Text(
        'Pick Color',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      color: Color(widget.note.color),
    );
  }

  // Function to determine contrasting text color
  Color getContrastingTextColor(Color backgroundColor) {
    return backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
