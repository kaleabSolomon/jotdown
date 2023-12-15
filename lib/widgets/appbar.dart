import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final bool isDarkMode;
  VoidCallback toggleDarkMode;
  MyAppBar(
      {super.key,
      required this.height,
      required this.isDarkMode,
      required this.toggleDarkMode});

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
      backgroundColor: Colors.green,
      title: Text(
        "Jot Down",
        style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            letterSpacing: 2,
            fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          onPressed: widget.toggleDarkMode,
          icon: Icon(
              size: 35,
              widget.isDarkMode
                  ? Icons.wb_sunny_outlined
                  : Icons.dark_mode_outlined),
        )
      ],
    );
  }
}
