import 'package:flutter/material.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Hero(
          tag: 'hero1',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              'assets/landscape.jpg',
              color: Colors.greenAccent,
              colorBlendMode: BlendMode.multiply,
            ),
          ),
        ),
        FittedBox(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 50.0,
              letterSpacing: 50.0,
              color: Colors.green.shade50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
