import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) =>
      MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.blue[800],
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    'Hello, Yipmong!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: .bold,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blue[600],
                    ),
                    padding: EdgeInsets.all(12),
                    child: IconButton(icon: Icon(Icons.notifications), color: Colors.white, onPressed: (){},),
                  ),
                ],
              ),
              Text('22 Jan, 2026', style: TextStyle(color: Colors.blue[300])),
              SizedBox(height: 25),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search, color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Search',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    'How do you Feel?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: .bold,
                    ),
                  ),
                  Icon(Icons.more_horiz, color: Colors.white),
                ],
              ),
              SizedBox(height: 16),
              //How do you feel
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  EmojiFeel(emoji: '😂', label: 'Laugh'),
                  EmojiFeel(emoji: '🤣', label: 'mad'),
                  EmojiFeel(emoji: '🤭', label: 'giggles'),
                  EmojiFeel(emoji: '🥷🏼', label: 'Ninja'),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 60),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            height: 600,
            width: 1000,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Icon(Icons.more_horiz),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 26, right: 34),
                      child: Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Text(
                            'Excercises',
                            style: TextStyle(fontWeight: .bold, fontSize: 20),
                          ),
                          Icon(Icons.more_horiz),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Excercises(
                        excercise: 'Speaking Skills',
                        excercises: 10,
                        icon: Icons.mic,
                        iconColor: Colors.purple,
                      ),
                      Excercises(
                        icon: Icons.numbers,
                        iconColor: Colors.yellow,
                        excercise: 'Learn the Numbers',
                        excercises: 26,
                      ),
                      Excercises(icon: Icons.music_note, iconColor: Colors.orange, excercise: 'Sing Rhymes', excercises: 22),
                      Excercises(icon: Icons.place, iconColor: Colors.green, excercise: 'Learn the Names of Places', excercises: 6),
                      Excercises(icon: Icons.abc, iconColor: Colors.red, excercise: 'Learn the ABC', excercises: 36)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class Excercises extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String excercise;
  final int excercises;

  const Excercises({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.excercise,
    required this.excercises,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.grey[100], size: 24),
              ),
            ),
            Column(
              crossAxisAlignment: .start,

              children: [
                Text(
                  excercise,
                  style: TextStyle(fontWeight: .bold, fontSize: 18),
                ),
                Text(
                  '$excercises Excercises',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[500],
                    fontWeight: .bold,
                  ),
                ),
              ],
            ),
            Icon(Icons.more_horiz),
          ],
        ),
      ),
    );
  }
}

class EmojiFeel extends StatelessWidget {
  final String emoji;
  final String label;

  const EmojiFeel({super.key, required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue[600],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(emoji, style: TextStyle(fontSize: 35)),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontWeight: .bold),
        ),
      ],
    );
  }
}
