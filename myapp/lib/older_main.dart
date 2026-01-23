import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// This is the root of your application
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int level = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("User Profile"),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  "https://blob.sololearn.com/avatars/9f25a6bd-bb35-47f2-8a76-e73f1e6ffe74.jpg",
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Yipmong Said Lvl($level)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              ContactCard(icon: Icons.email, text: "Syi@mail.com"),
              ContactCard(icon: Icons.phone, text: "070468282822"),
              const SizedBox(height: 20),

              // 4. The Button
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              level++;
            });
          },
          child: Icon(Icons.add),
        ),
        drawer: SideDrawer(),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final IconData icon;
  final String text;

  const ContactCard({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListTile(leading: Icon(icon), title: Text(text)),
    );
  }
}

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // Removes white space at the top
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                "Menu",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                // We will learn navigation later!
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
              },
            ),
          ],
        ),
      );
  }
}
