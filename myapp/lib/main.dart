import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: FirstScreen());
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController _taskController = TextEditingController();
  final List<Task> tasks = [
    Task(name: "Buy Milk", isCompleted: false),
    Task(name: "Walk the Dog", isCompleted: false),
    Task(name: "Code Flutter", isCompleted: false),
    Task(name: "Eat Pizza", isCompleted: true),
  ];

  void _refresh() async {
    setState(() {
      tasks.add(Task(name: 'Download ME', isCompleted: false));
    });
  }

  void _newTask() async {
    setState(() {
      tasks.insert(0, Task(name: _taskController.text, isCompleted: false));
      _saveTasks();
      _taskController.clear();
      Navigator.pop(context);
    });
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();

    final String data = jsonEncode(tasks.map((task) => task.toMap()).toList());

    await prefs.setString('my_task', data);
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('my_task');

    if (data != null) {
      final List<dynamic> decodedList = jsonDecode(data);

      final List<Task> loadedTasks = decodedList
          .map((item) => Task.fromMap(item))
          .toList();

      setState(() {
        tasks.clear();
        tasks.addAll(loadedTasks);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 1000,
            height: 100,
            decoration: BoxDecoration(color: Colors.amber),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: .spaceAround,
                children: [
                  Text(
                    'Hey, Yipmong!',
                    style: TextStyle(
                      fontWeight: .bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _refresh();
                    },
                    icon: Icon(Icons.refresh, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text('Enter a new Task'),
                          title: Text('Add New Task'),
                          actions: [
                            TextField(controller: _taskController),
                            IconButton(
                              onPressed: () {
                                _newTask();
                              },
                              icon: Icon(Icons.send),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(Icons.add, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: _downloadTodo,
                    icon: Icon(
                      Icons.cloud_download_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) => Dismissible(
                key: Key(tasks[index].name),
                onDismissed: (direction) {
                  setState(() {
                    tasks.removeAt(index);
                    _saveTasks();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Task at Number $index had been removed'),
                    ),
                  );
                },
                background: Container(color: Colors.red),
                secondaryBackground: Container(color: Colors.green),
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: ListTile(
                    title: Text(
                      tasks[index].name,
                      style: TextStyle(
                        decoration: tasks[index].isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: tasks[index].isCompleted
                            ? Colors.grey
                            : Colors.green,
                      ),
                    ),
                    leading: IconButton(
                      icon: tasks[index].isCompleted
                          ? Icon(Icons.check_circle_outline, color: Colors.grey)
                          : Icon(Icons.circle_outlined, color: Colors.green),
                      onPressed: () => setState(() {
                        tasks[index].isCompleted = !tasks[index].isCompleted;
                        _saveTasks();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: tasks[index].isCompleted
                                ? Text(
                                    '$index Task has been marked  and completed',
                                  )
                                : Text('$index Task has been unmarked'),
                          ),
                        );
                      }),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          tasks.removeAt(index);
                          _saveTasks();
                        });
                      },
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SecondScreen(data: tasks[index].name),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
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
                TextButton(onPressed: () => _newTask(), child: Text("Submit")),
              ],
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _downloadTodo() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos/2'));
    if (response.statusCode == 200){
      Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        tasks.add(Task(name: data['title'], isCompleted: data['completed']));
        _saveTasks();
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Request failed with Status Code ${response.statusCode}')));
    }
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

class Task {
  String name;
  bool isCompleted;

  Task({required this.name, required this.isCompleted});

  Map<String, dynamic> toMap() => {'name': name, 'isCompleted': isCompleted};

  factory Task.fromMap(Map<String, dynamic> map) =>
      Task(name: map['name'], isCompleted: map['isCompleted']);
}
