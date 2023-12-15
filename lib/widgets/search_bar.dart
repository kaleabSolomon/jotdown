import 'package:flutter/material.dart';

class SearchNotes extends StatefulWidget {
  const SearchNotes({super.key});

  @override
  State<SearchNotes> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchNotes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Theme.of(context).colorScheme.primary, width: 2))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: SearchBar(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            return Theme.of(context).colorScheme.tertiary;
          }),
          textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
              (Set<MaterialState> states) {
            return TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold);
          }),
          hintText: "Search Notes",
          hintStyle: MaterialStateProperty.resolveWith<TextStyle?>(
            (Set<MaterialState> states) {
              return const TextStyle(
                color: Color.fromARGB(255, 74, 80, 85),
                fontStyle: FontStyle.italic,
              );
            },
          ),
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(
              size: 30,
              Icons.search,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
