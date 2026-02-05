import 'package:flutter/material.dart';

import 'question_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detector de Mentira'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shield_moon,
              size: 120,
            ),
            const SizedBox(height: 24),
            Text(
              'Descubra a verdade com uma experiência divertida e interativa.',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pushNamed(QuestionScreen.routeName);
              },
              child: const Text('Começar'),
            ),
          ],
        ),
      ),
    );
  }
}
