import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String placeholder;

  const TextFieldWidget({required this.placeholder, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(decoration: InputDecoration(hintText: placeholder));
  }
}
