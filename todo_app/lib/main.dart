import 'package:flutter/material.dart';
import 'package:todo_app/example/beautiful_card.dart';
import 'package:todo_app/features/todo/presentation/widgets/appbar_widget.dart';

void main() =>
  runApp(const ToDoApp());


class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              BeautifulCard(),
            ],
          ),
        ),
      ),
    );
  }
}