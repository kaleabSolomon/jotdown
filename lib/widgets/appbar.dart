import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  const MyAppBar({super.key, required this.height});

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
        title: Center(
          child: Image.asset(
            "assets/logo.png",
            height: 80,
            width: 80,
            color: Colors.black,
          ),
        ));
  }
}
