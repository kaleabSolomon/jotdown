import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:jotdown/model/note.dart';
import 'package:jotdown/pages/add_note_page.dart';
import 'package:jotdown/pages/note_page.dart';
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

  TextEditingController searchBarController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initialize app bar actions
    _appBarActions = [
      IconButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddNotePage(
                        isDarkMode: isDarkMode,
                      )));
        },
        icon: Icon(
            color: Theme.of(context).colorScheme.primary, size: 40, Icons.add),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final notesBox = Hive.box<Note>('notesBox');
    final String keyWord = searchBarController.text;

    isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    List<Note> results = notesBox.values
        .where(
            (note) => note.title.toLowerCase().contains(keyWord.toLowerCase()))
        .toList();
    // Get all the notes from the box
    List<Note> notes = List.from(results.reversed);
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
              SearchNotes(controller: searchBarController),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                    child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: notes.isEmpty
                      ? SvgPicture.asset(
                          "assets/no_notes.svg",
                          height: 150,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : ListView.builder(
                          itemCount: notes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NotePage(
                                              note: notes[index],
                                              isDarkMode: isDarkMode,
                                            )));
                              },
                              onLongPress: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Delete Note?"),
                                        content: const Text(
                                            "Are you sure you want to delete this note?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  notesBox.deleteAt(notesBox
                                                          .values
                                                          .toList()
                                                          .length -
                                                      1 -
                                                      index);
                                                });

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content: Text(
                                                    "Note deleted",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 210, 62, 62),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  duration:
                                                      Duration(seconds: 2),
                                                ));
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Delete")),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancel"))
                                        ],
                                      );
                                    });
                              },
                              child: NoteTile(
                                title: notes[index].title,
                                content: notes[index].content,
                                createdAt: notes[index].createdAt,
                              ),
                            );
                          }),
                )),
              )
            ],
          ),
        ));
  }
}
