import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstScreen());
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

  Future<void> _saveTasks() async{
    final prefs = await SharedPreferences.getInstance();

    final String data = jsonEncode(tasks.map((task)=> task.toMap()).toList());

    await prefs.setString('my_task', data);
  }

  Future<void> _loadTasks() async{
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('my_task');

    if(data != null){

      final List<dynamic> decodedList = jsonDecode(data);
      

      final List<Task> loadedTasks = decodedList.map((item)=> Task.fromMap(item)).toList();


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
        appBar: AppBar(title: Text('First Screen'),
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: ()async {
            await Future.delayed(Duration(seconds: 2));
            setState(() {
              tasks.add(Task(name: "Tasks Downloaded", isCompleted: false));
              _saveTasks();
            });
          },)
        ],),
        body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(
              tasks[index].name,
              style: TextStyle(
                decoration: tasks[index].isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                color: tasks[index].isCompleted
                    ? Colors.grey
                    : Colors.greenAccent,
              ),
            ),
            leading: IconButton(
              icon: tasks[index].isCompleted
                  ? Icon(Icons.check_circle_outline, color: Colors.grey)
                  : Icon(Icons.circle_outlined, color: Colors.greenAccent),
              onPressed: () => setState(() {
                tasks[index].isCompleted = !tasks[index].isCompleted;
                _saveTasks();
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
                builder: (context) => SecondScreen(data: tasks[index].name),
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
                      tasks.insert(
                        0,
                        Task(name: _taskController.text, isCompleted: false),
                      );
                      _saveTasks();
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

class Task {
  String name;
  bool isCompleted;

  Task({required this.name, required this.isCompleted});

  Map<String, dynamic> toMap() => {'name': name, 'isCompleted': isCompleted};

  factory Task.fromMap(Map<String, dynamic> map) =>
      Task(name: map['name'], isCompleted: map['isCompleted']);
}
