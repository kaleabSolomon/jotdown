import 'package:flutter/material.dart';
import 'package:jotdown/model/note.dart';
import 'package:jotdown/theme/theme_provider.dart';
import 'package:jotdown/widgets/appbar.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  final Note note;
  const NotePage({super.key, required this.note});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool isEditing = false;

  bool isDarkMode = false;
  void toggleTheme() {
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
  }

  List<Widget> _appBarActions = [];
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
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Your Note",
        height: MediaQuery.of(context).size.height * 0.1,
        isDarkMode: isDarkMode,
        toggleDarkMode: toggleTheme,
        appBarActions: _appBarActions,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            titleField(),
            const SizedBox(
              height: 16,
            ),
            Expanded(child: contentField())
          ],
        ),
      ),
    );
  }

  Widget titleField() {
    return TextField(
      controller: _titleController,
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

  Widget contentField() {
    return TextField(
      controller: _contentController,
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
