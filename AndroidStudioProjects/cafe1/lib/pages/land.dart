import 'dart:ui';
import 'package:cafe1/home/home.dart';
import 'package:cafe1/pages/login.dart';
import 'package:flutter/material.dart';


void handleLogin(BuildContext context){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=>LoginPage()),
  );
}

class CoffeePage extends StatelessWidget {
  const CoffeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image with Blur Effect
          Positioned.fill(
            child: Image.asset(
              'assets/coffee_mug.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.3), // Overlay to darken the image
              ),
            ),
          ),

          // Foreground content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title Text
                  Text.rich(
                    TextSpan(
                        text: 'Coffee So Good\nYour Taste Buds\nWill ',

                        children: <TextSpan>[
                          TextSpan(
                            text: 'Love',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w100,
                                color: Colors.amber),
                          ),

                          TextSpan(
                              text: ' it.'
                          )
                        ]

                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 212, 212, 212),
                      height: 1.5,
                      letterSpacing: 1.2,
                    ),
                  ),

                  SizedBox(height: 60),

                  // Login Button
                  ElevatedButton(
                    onPressed: () {
                      // Handle login logic
                      handleLogin(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                      backgroundColor: const Color(0xFF964B00),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Explore Button
                  TextButton(
                    onPressed: () {
                      // Handle explore navigation
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>HomePage()));
                    },
                    child: Text(
                      'Explore >',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
