import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteTile extends StatefulWidget {
  final String title;
  final String content;
  final DateTime createdAt;
  const NoteTile({
    super.key,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  // DateTime currentDate = DateTime.now();

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
                  widget.title,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
                Text(
                  widget.content,
                  maxLines: 2,
                ),
              ],
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Text(
                //TODO: display date only if next day. else display time
                DateFormat.yMMMd('en_US').format(widget.createdAt),
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            )
          ]),
        ));
  }
}
