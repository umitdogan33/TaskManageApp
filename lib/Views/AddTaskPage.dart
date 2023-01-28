import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text("Add Task"),
      backgroundColor: Colors.amber[800],
    ),body: Text("Body Text"),);
  }
}