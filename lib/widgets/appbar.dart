import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final String title;
  final bool isDarkMode;
  VoidCallback toggleDarkMode;
  List<Widget> appBarActions;
  MyAppBar(
      {super.key,
      required this.height,
      required this.title,
      required this.isDarkMode,
      required this.toggleDarkMode,
      required this.appBarActions});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: widget.height,
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text(
        widget.title,
        style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            letterSpacing: 2,
            fontWeight: FontWeight.bold),
      ),
      actions: [
        ...widget.appBarActions,
        IconButton(
          onPressed: widget.toggleDarkMode,
          icon: Icon(
              color: Theme.of(context).colorScheme.primary,
              size: 35,
              widget.isDarkMode
                  ? Icons.wb_sunny_outlined
                  : Icons.dark_mode_outlined),
        ),
      ],
    );
  }
}
