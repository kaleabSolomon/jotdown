import 'package:flutter/material.dart';
import 'package:jotdown/widgets/appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 231, 222, 196),
        appBar: MyAppBar(
          height: MediaQuery.of(context).size.height * 0.1,
        ));
  }
}
