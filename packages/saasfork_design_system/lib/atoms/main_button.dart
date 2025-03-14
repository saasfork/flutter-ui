import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const MainButton({required this.label, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(label));
  }
}
