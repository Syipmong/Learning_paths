import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:myapp/config/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final titleProvider = Provider<String>((ref) => "RiverPod Task Manager",);
final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref){
  return TaskNotifier();
});

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String appTitle = ref.watch(titleProvider);
    return MaterialApp(debugShowCheckedModeBanner: false, home: FirstScreen(appTitle: appTitle,));
  }
}

class FirstScreen extends ConsumerStatefulWidget {
  final String appTitle;
  const FirstScreen({super.key, required this.appTitle});

  @override
  ConsumerState<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends ConsumerState<FirstScreen> {
  final TextEditingController _taskController = TextEditingController();
  bool isLoading = false;



  // void _refresh() async{
  //   setState((){
  //     tasks.add(Task(name: "Test 1", isCompleted: false));
  //   });
  // }






  void _downloadTodo() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/todos?_limit=5'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> dataList = jsonDecode(response.body);
        
          
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Request failed with Status Code ${response.statusCode}'), backgroundColor: Colors.red,));
        throw Exception('Server Error: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('an error occured, please check your internet'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskProvider);
    return Scaffold(
      appBar: AppBar(title: Text(widget.appTitle),),
      body: Column(
        children: [
          Container(
            width: 1000,
            height: 100,
            decoration: BoxDecoration(color: AppColors.brandred),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: .spaceAround,
                children: [
                  Text(
                    "Hello Yipmong!",
                    style: TextStyle(
                      fontWeight: .bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      
                    },
                    icon: Icon(Icons.refresh, color: Colors.white, size: 20.0,),
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
                                ref.read(taskProvider.notifier).addTask(_taskController.text);
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
                    icon: isLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.red,
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Icon(
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
                  ref.read(taskProvider.notifier).removeTask(index);
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
                      onPressed: (){
                        ref.read(taskProvider.notifier).toggleTask(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: tasks[index].isCompleted
                                ? Text(
                                    '$index Task has been marked  and completed',
                                  )
                                : Text('$index Task has been unmarked'),
                          ),
                        );
                      }
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        ref.read(taskProvider.notifier).removeTask(index);
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
                TextButton(onPressed: () => ref.read(taskProvider.notifier).addTask(_taskController.text), child: Text("Submit")),
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



class TaskNotifier extends StateNotifier<List<Task>>{
  TaskNotifier(): super([
    Task(name: 'Yippy Rizz', isCompleted: false),
    Task(name: 'Juicy Tosan', isCompleted: false)
  ]);


  //--- MEMORY ----
  Future<void> saveTasks()async{
    final prefs = await SharedPreferences.getInstance();
    final String data = jsonEncode(state.map((task)=> task.toMap()).toList());
    await prefs.setString('my_tasks', data);
  }

  Future<void> loadTasks()async{
    final prefs = await SharedPreferences.getInstance();
    final String? data  = prefs.getString('my_tasks');

    if(data != null){
    final List<dynamic> decodedList = jsonDecode(data);
    final List<Task> loadedTasks = decodedList.map((item)=> Task.fromMap(item)).toList(); 
    state = loadedTasks;
    }else{
      state = [
        Task(name: "Yippy Rizz", isCompleted: false),
        Task(name: "Juicy Tosan", isCompleted: true)
      ];
    }

  }

  void addTask(String task){
    state = [Task(name: task, isCompleted: false), ...state];
    saveTasks();
  }

  void removeTask(int index){
    state = [for (int i= 0; i < state.length; i++)
      if(i!=index) state[i]
    ];
    saveTasks();
  }

  void toggleTask(int index){
    state = [
      for (int i = 0; i < state.length; i++)
        if(i == index)
          Task(name: state[i].name, isCompleted: !state[i].isCompleted)
        else
          state[i]
    ];
    saveTasks();
  }
}