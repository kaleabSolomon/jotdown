import 'dart:async';

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
  late Timer _timer;
  String formattedDuration = "";

  @override
  void initState() {
    super.initState();
    updateDuration();
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer t) {
      updateDuration();
    });
  }

  void updateDuration() {
    Duration difference = DateTime.now().difference(widget.createdAt);
    setState(() {
      if (difference.inSeconds < 60) {
        formattedDuration = "Just Now";
      } else if (difference.inSeconds >= 60 && difference.inMinutes < 60) {
        formattedDuration = "${difference.inMinutes} minutes ago";
      } else if (difference.inMinutes >= 60 && difference.inHours < 6) {
        formattedDuration = "${difference.inHours} hours ago";
      } else {
        DateFormat.yMMMd('en_US').format(widget.createdAt);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width * 0.4,
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
                formattedDuration,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            )
          ]),
        ));
  }
}
