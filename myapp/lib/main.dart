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

class FirstScreen extends StatelessWidget {
  FirstScreen({super.key});

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("First Screen")),
      body: Column(
        mainAxisAlignment: .center,
        children: [
          TextField(
            controller: _controller,
          ),
          ElevatedButton(
            onPressed: () async {
             final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondScreen(data: _controller.text,)),
              );
              print("Returned: $result");
            },
            child: Text("Go To SecondScreen"),
            
          ),
        ],
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
