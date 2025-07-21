import 'package:flutter/material.dart';
import 'package:pydaily/models/user.dart';
import 'package:pydaily/screens/home_screen.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key, required this.user});

  final User user;
  final String logo = 'assets/imagenes/PyDaily.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.blueAccent,
                  width: 3,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  logo,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => 
                    const Icon(Icons.code, size: 60, color: Colors.blueAccent),
                ),
              ),
            ),
            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(initialUser: user),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40, 
                  vertical: 18,
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('Empezar retos'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}