import 'package:flutter/material.dart';

class CustomActionIcon extends StatelessWidget {
  const CustomActionIcon({super.key, required this.icon, this.onPressed});
  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(25), // Fixed the method name
        borderRadius: BorderRadius.circular(16),
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
      ),
    );
  }
}