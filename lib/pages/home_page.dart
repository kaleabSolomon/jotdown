import 'package:flutter/material.dart';
import 'package:jotdown/theme/theme_provider.dart';
import 'package:jotdown/widgets/appbar.dart';
import 'package:jotdown/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDarkMode = false;

  void toggleTheme() {
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: MyAppBar(
          height: MediaQuery.of(context).size.height * 0.1,
          isDarkMode: isDarkMode,
          toggleDarkMode: toggleTheme,
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: [SearchNotes()],
          ),
        ));
  }
}
