import 'package:flutter/material.dart';

class TitleField extends StatelessWidget {
  final TextEditingController titleController;
  final bool isTitleFieldEmpty;
  const TitleField(
      {super.key,
      required this.titleController,
      required this.isTitleFieldEmpty});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: titleController,
      style:
          TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.primary),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        // error: Text("Title is required"),
        hintText: 'Enter Title Here',
        errorText: isTitleFieldEmpty ? "a title is required" : null,
        hintStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
