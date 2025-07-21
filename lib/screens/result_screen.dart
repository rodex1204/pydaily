import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final bool isCorrect;
  final String explanation;
  final int xpEarned;

  const ResultScreen({
    super.key,
    required this.isCorrect,
    required this.explanation,
    required this.xpEarned,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isCorrect ? Icons.check_circle : Icons.error,
              color: isCorrect ? Colors.green : Colors.red,
              size: 100,
            ),
            Text(
              isCorrect ? '¡Correcto! +$xpEarned XP' : 'Incorrecto',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                explanation,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}