import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jotdown/model/note.dart';
import 'package:jotdown/theme/theme_provider.dart';
import 'package:jotdown/widgets/appbar.dart';
import 'package:jotdown/widgets/contet_field.dart';
import 'package:jotdown/widgets/title_field.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatefulWidget {
  final bool isDarkMode;
  const AddNotePage({super.key, required this.isDarkMode});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  //TODO: add undo to deletion
  // TODO: display last entered note first

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void toggleTheme() {
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
  }

  List<Widget> _appBarActions = [];
  bool isTitleFieldEmpty = false;
  bool isContentFieldEmpty = false;
  final notesBox = Hive.box<Note>('notesBox');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // initialize app bar actions
    _appBarActions = [
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

          if (!isTitleFieldEmpty && !isContentFieldEmpty) {
            // get required data
            String title = _titleController.text;
            String content = _contentController.text;
            DateTime createdAt = DateTime.now();

            // create a note object

            Note note =
                Note(title: title, content: content, createdAt: createdAt);
            // save notes to hive
            try {
              notesBox.add(note);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  "1 Note Created",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                backgroundColor: Color.fromARGB(255, 70, 214, 75),
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 2),
              ));
            } catch (e) {
              print('Error adding note to Hive: $e');
            }

            // clear textFields
            _titleController.clear();
            _contentController.clear();

            Navigator.of(context).pop();
          }
        },
        icon: Icon(
            color: Theme.of(context).colorScheme.primary, size: 30, Icons.save),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: "Add A Note",
          height: MediaQuery.of(context).size.height * 0.1,
          isDarkMode: widget.isDarkMode,
          toggleDarkMode: toggleTheme,
          appBarActions: _appBarActions,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TitleField(
                titleController: _titleController,
                isTitleFieldEmpty: isTitleFieldEmpty,
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                  child: ContentField(
                contentController: _contentController,
                isContentFieldEmpty: isContentFieldEmpty,
              ))
            ],
          ),
        ));
  }
}
