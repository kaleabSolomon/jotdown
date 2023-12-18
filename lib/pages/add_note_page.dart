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

  void toggleTheme() {
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
  }

  List<Widget> _appBarActions = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // initialize app bar actions
    _appBarActions = [
      IconButton(
        onPressed: () {},
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
                style: TextStyle(
                    fontSize: 24, color: Theme.of(context).colorScheme.primary),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  // error: Text("Title is required"),
                  hintText: 'Enter title here',
                  hintStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
