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
        // TODO: make the height dynamic
        height: 110,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Note Title",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
                const Text(
                  "note content  ",
                  maxLines: 2,
                ),
              ],
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Text(
                '${currentDate.year}-${currentDate.month}-${currentDate.day}',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            )
          ]),
        ));
  }
}
