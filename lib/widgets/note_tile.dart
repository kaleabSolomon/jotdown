import 'package:flutter/material.dart';

class NoteTile extends StatefulWidget {
  const NoteTile({super.key});

  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 250,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 130, 121, 87),
              offset: Offset(
                1.0,
                1.0,
              ),
              blurRadius: 5.0,
              spreadRadius: 1.0,
            )
          ]),
      child: Text("hello world"),
    );
  }
}
