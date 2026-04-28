import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_stash/screens/home_screen.dart';

void main() {
  runApp(
    ProviderScope(
      child: const QuoteStash()
    )
  );
}


class QuoteStash extends StatelessWidget {
  const QuoteStash({super.key});

  @override
  Widget build(BuildContext context) {    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
