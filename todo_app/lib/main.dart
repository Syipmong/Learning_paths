import 'package:flutter/material.dart';
import 'package:todo_app/features/todo/presentation/widgets/appbar_widget.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            AppbarWidget()
          ],
        ),
      ),
    );
  }
}