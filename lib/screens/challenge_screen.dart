import 'package:flutter/material.dart';
import 'package:pydaily/models/challenge.dart';
import 'package:pydaily/screens/result_screen.dart';

class ChallengeScreen extends StatefulWidget {
  final Challenge challenge;
  const ChallengeScreen({super.key, required this.challenge});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  int? selectedAnswerIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.challenge.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              widget.challenge.question, 
              style: Theme.of(context).textTheme.titleLarge
            ),
            const SizedBox(height: 20),
            ...widget.challenge.options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              return RadioListTile<int>(
                title: Text(option),
                value: index,
                groupValue: selectedAnswerIndex,
                onChanged: (value) => setState(() => selectedAnswerIndex = value),
              );
            }),
            const Spacer(),
            ElevatedButton(
              onPressed: selectedAnswerIndex != null ? () async {
                final isCorrect = selectedAnswerIndex == widget.challenge.correctAnswerIndex;
                
                // Navegar a ResultScreen y esperar el resultado
                final shouldUpdate = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ResultScreen(
                      isCorrect: isCorrect,
                      explanation: widget.challenge.explanation,
                      xpEarned: isCorrect ? widget.challenge.xp : 0,
                    ),
                  ),
                );

                // Si el usuario presionó "Continuar" en ResultScreen
                if (shouldUpdate == true && context.mounted) {
                  Navigator.pop(context, isCorrect);
                }
              } : null,
              child: const Text('Ver resultado'),
            ),
          ],
        ),
      ),
    );
  }
}