import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          width: 400,
          height: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
            colors: [Colors.red, Colors.amber],),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            
          ),
          child: ListTile(
            leading: FaIcon(FontAwesomeIcons.comment),
            title: Text('Name'),
            subtitle: Text("Ypmong Said"),
          ),
        ),
      ),
      floatingActionButton: IconButton(onPressed: (){}, icon: FaIcon(FontAwesomeIcons.google))
      ,
    );
  }
}
