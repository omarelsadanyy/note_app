import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:note_app/widgets/custom_button.dart';

class AddNoteColorPicker extends StatefulWidget {
  const AddNoteColorPicker({super.key});

  @override
  State<AddNoteColorPicker> createState() => _AddNoteColorPickerState();
}

class _AddNoteColorPickerState extends State<AddNoteColorPicker> {
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
              BlocProvider.of<AddNoteCubit>(context).color = selectedColor;
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
      text: Text(
        'Pick Color',
        style: TextStyle(
          color: getContrastingTextColor(selectedColor),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      color: selectedColor,
    );
  }

  // Function to determine contrasting text color
  Color getContrastingTextColor(Color backgroundColor) {
    return backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
