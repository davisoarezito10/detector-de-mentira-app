import 'package:flutter/material.dart';

import 'analysis_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  static const routeName = '/question';

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnalysis() {
    if (_controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Digite uma pergunta para continuar.')),
      );
      return;
    }

    Navigator.of(context).pushNamed(
      AnalysisScreen.routeName,
      arguments: _controller.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sua pergunta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Escreva a pergunta que deseja analisar:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              maxLines: 3,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                hintText: 'Ex: Você está dizendo a verdade?',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: _startAnalysis,
              icon: const Icon(Icons.analytics_outlined),
              label: const Text('Iniciar análise'),
            ),
          ],
        ),
      ),
    );
  }
}
