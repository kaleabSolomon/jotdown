import 'package:flutter/material.dart';

class NoteTile extends StatefulWidget {
  const NoteTile({super.key});

  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width * 0.4,
        height: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("note title"),
            Text("note content"),
            Text('${currentDate.year}-${currentDate.month}-${currentDate.day}')
          ],
        ));
  }
}
