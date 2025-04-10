import 'package:f1/views/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lottie/home.json',
                  height: 400.0,
                ),
                FittedBox(
                  child: Text(
                    'Banco',
                    style: TextStyle(
                      color: Colors.green.shade200,
                      fontWeight: FontWeight.bold,
                      fontSize: 50.0,
                      letterSpacing: 30.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginPage(title: 'Register',);
                        },
                      ),
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.green.shade100,
                    minimumSize: Size(double.infinity, 50.0),
                  ),
                  child: Text('Get Started'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginPage(title: 'Login',);
                        },
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    minimumSize: Size(double.infinity, 50.0),
                  ),
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
