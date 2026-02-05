import 'dart:math';

import 'package:flutter/material.dart';

import 'question_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  static const routeName = '/result';

  @override
  Widget build(BuildContext context) {
    final question = ModalRoute.of(context)?.settings.arguments as String? ?? '';
    final results = [
      'Verdade!',
      'Mentira!',
      'Inconclusivo',
    ];
    final randomResult = results[Random().nextInt(results.length)];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.fact_check,
              size: 120,
            ),
            const SizedBox(height: 24),
            if (question.isNotEmpty)
              Text(
                'Pergunta: "$question"',
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 16),
            Text(
              randomResult,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  QuestionScreen.routeName,
                  (route) => route.isFirst,
                );
              },
              child: const Text('Nova pergunta'),
            ),
          ],
        ),
      ),
    );
  }
}
