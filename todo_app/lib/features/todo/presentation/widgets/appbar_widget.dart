import 'package:flutter/material.dart';
import 'package:todo_app/config/colors.dart';

class AppbarWidget extends StatelessWidget {
  final String name;
  final int tasktotal;

  const AppbarWidget({super.key, required this.name, required this.tasktotal });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.accentTeal,
      width: 600,
      height: 250,
      
      
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text("Hello, $name", style: TextStyle(
            fontSize: 30,
            fontWeight: .bold
          ),),
          Column(
            crossAxisAlignment: .start,
            children: [
              Text('You have', style: TextStyle(
                fontSize: 30,
                fontWeight: .bold,
                
              ),
              ),
              Text('$tasktotal tasks today', style: TextStyle(
                fontSize: 30,
                fontWeight: .bold,
              ),)
            ],
          )
        ],
      ),
    );
  }
}