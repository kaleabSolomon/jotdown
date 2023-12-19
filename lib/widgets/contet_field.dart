import 'package:flutter/material.dart';

class ContentField extends StatelessWidget {
  final TextEditingController contentController;
  final bool isContentFieldEmpty;
  const ContentField(
      {super.key,
      required this.contentController,
      required this.isContentFieldEmpty});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: contentController,
      style:
          TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 18),
      maxLines: null,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        errorText: isContentFieldEmpty ? "A note should have a content" : null,
        hintText: "Enter Content Here",
        hintStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
