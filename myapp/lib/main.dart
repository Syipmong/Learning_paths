import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: FirstScreen());
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final List<String> tasks = [
    "Buy Milk",
    "Walk the Dog",
    "Code Flutter",
    "Eat Pizza",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("First Screen")),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(tasks[index]),
          leading: Icon(Icons.check_circle_outline),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SecondScreen(data: tasks[index]),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Add Button Clicked!");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final String data;

  const SecondScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(title: Text("Second Screen")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context, "Message: This is the response Data");
          },
          child: Text(data),
        ),
      ),
    );
  }
}
