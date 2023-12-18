import 'package:flutter/material.dart';
import 'package:jotdown/pages/add_note_page.dart';
import 'package:jotdown/theme/theme_provider.dart';
import 'package:jotdown/widgets/appbar.dart';
import 'package:jotdown/widgets/note_tile.dart';
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

  List<Widget> _appBarActions = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // initialize app bar actions
    _appBarActions = [
      IconButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddNotePage()));
        },
        icon: Icon(
            color: Theme.of(context).colorScheme.primary, size: 40, Icons.add),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: MyAppBar(
          title: "Jot Down",
          height: MediaQuery.of(context).size.height * 0.1,
          isDarkMode: isDarkMode,
          toggleDarkMode: toggleTheme,
          appBarActions: _appBarActions,
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: [
              const SearchNotes(),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                    child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.builder(
                      itemCount: 8,
                      itemBuilder: (BuildContext context, int index) {
                        return NoteTile(
                          title: 'here',
                          content: 'note content',
                          createdAt: DateTime.now(),
                        );
                      }),
                )),
              )
            ],
          ),
        ));
  }
}
