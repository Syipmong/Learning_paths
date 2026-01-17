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
  final TextEditingController _taskController = TextEditingController();
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
          trailing: IconButton(icon: Icon(Icons.delete),onPressed:(){
            setState(() {
              tasks.removeAt(index);
            });
          } ),
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
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("New Task"),
              content: TextField(
                controller: _taskController,
                decoration: InputDecoration(hintText: "Enter Task Name"),
              ),
              actions: [
                TextButton(
                  onPressed: () => setState(() {
                    tasks.add(_taskController.text);
                    _taskController.clear();
                    Navigator.pop(context);
                  }),
                  child: Text("Submit"),
                ),
              ],
            ),
          );
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
