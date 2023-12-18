import 'package:flutter/material.dart';
import 'package:jotdown/theme/theme_provider.dart';
import 'package:jotdown/widgets/appbar.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  //FIXME: light-dark mode icons not interchanging
  bool isDarkMode = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void toggleTheme() {
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
  }

  List<Widget> _appBarActions = [];
  bool isTitleFieldEmpty = false;
  bool isContentFieldEmpty = false;

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

          print(
              'title: ${_titleController.text.trim()} and content:${_contentController.text.trim()}');
          // save notes to hive
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
          isDarkMode: isDarkMode,
          toggleDarkMode: toggleTheme,
          appBarActions: _appBarActions,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                style: TextStyle(
                    fontSize: 24, color: Theme.of(context).colorScheme.primary),
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
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                  child: TextField(
                controller: _contentController,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary, fontSize: 18),
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  errorText:
                      isTitleFieldEmpty ? "A note should have a content" : null,
                  hintText: "Enter Content Here",
                  hintStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ))
            ],
          ),
        ));
  }
}
