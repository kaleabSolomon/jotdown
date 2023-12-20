import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jotdown/model/note.dart';
import 'package:jotdown/theme/theme_provider.dart';
import 'package:jotdown/widgets/appbar.dart';
import 'package:jotdown/widgets/contet_field.dart';
import 'package:jotdown/widgets/title_field.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  final Note note;
  final bool isDarkMode;
  const NotePage({super.key, required this.note, required this.isDarkMode});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool isEditing = false;
  bool isTitleFieldEmpty = false;
  bool isContentFieldEmpty = false;
  late Box<Note> notesBox;

  List<Widget> _appBarActions = [];

  void toggleTheme() {
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
  }

  @override
  void initState() {
    super.initState();
    notesBox = Hive.box<Note>('notesBox');
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
    _appBarActions = [
      IconButton(
          onPressed: updateNote,
          icon: Icon(
              color: Theme.of(context).colorScheme.primary,
              size: 30,
              Icons.save)),
      IconButton(
          onPressed: () {
            _titleController.text.isEmpty
                ? setState(() {
                    isTitleFieldEmpty = true;
                  })
                : setState(() {
                    isTitleFieldEmpty = false;
                  });
            _contentController.text.isEmpty
                ? setState(() {
                    isContentFieldEmpty = true;
                  })
                : setState(() {
                    isContentFieldEmpty = false;
                  });

            setState(() {
              if (!isTitleFieldEmpty && !isContentFieldEmpty) {
                if (isEditing) {
                  widget.note.title = _titleController.text;
                  widget.note.content = _contentController.text;
                }

                isEditing = !isEditing;
              }
            });
          },
          icon: Icon(
              color: Theme.of(context).colorScheme.primary,
              size: 30,
              isEditing ? Icons.done : Icons.edit))
    ];
  }

  void updateNote() {
    for (int i = 0; i < notesBox.length; i++) {
      Note selectedNote = notesBox.getAt(i)!;
      if (selectedNote.title == widget.note.title &&
          selectedNote.createdAt == widget.note.createdAt) {
        selectedNote.title = _titleController.text;
        selectedNote.content = _contentController.text;
        selectedNote.createdAt = DateTime.now();

        // update the note
        notesBox.putAt(i, selectedNote);
        break;
      }
    }

    Navigator.pop(context);
  }

//TODO: still needs work. unsaved notes are being displayed
  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Unsaved Changes"),
            content: const Text(
                "Are you sure you want to go back? unsaved changes might be lost"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text("Go Back")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) return;

        _showDialog();
      },
      child: Scaffold(
        appBar: MyAppBar(
          title: "Your Note",
          height: MediaQuery.of(context).size.height * 0.1,
          isDarkMode: widget.isDarkMode,
          toggleDarkMode: toggleTheme,
          appBarActions: _appBarActions,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isEditing
                  ? TitleField(
                      titleController: _titleController,
                      isTitleFieldEmpty: isTitleFieldEmpty,
                    )
                  : titleText(),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                  child: isEditing
                      ? ContentField(
                          contentController: _contentController,
                          isContentFieldEmpty: isContentFieldEmpty,
                        )
                      : contentText())
            ],
          ),
        ),
      ),
    );
  }

  Widget titleText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        widget.note.title,
        style: TextStyle(
            fontSize: 24, color: Theme.of(context).colorScheme.primary),
      ),
    );
  }

  Widget contentText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        widget.note.content,
        style: TextStyle(
            color: Theme.of(context).colorScheme.primary, fontSize: 18),
      ),
    );
  }
}
