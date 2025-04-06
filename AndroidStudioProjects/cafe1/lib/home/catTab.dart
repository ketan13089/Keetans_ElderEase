//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryTab extends StatelessWidget {
  final String title;
  CategoryTab({required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
          //future task
      },
       child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
    );
  }
}
