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
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
            color: Theme.of(context).colorScheme.primary, size: 40, Icons.save),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        height: MediaQuery.of(context).size.height * 0.1,
        isDarkMode: isDarkMode,
        toggleDarkMode: toggleTheme,
        appBarActions: _appBarActions,
      ),
      body: Center(
          child: Container(
        child: Text("hello world"),
      )),
    );
  }
}