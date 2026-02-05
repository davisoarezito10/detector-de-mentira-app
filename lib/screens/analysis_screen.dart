import 'dart:async';

import 'package:flutter/material.dart';

import 'result_screen.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  static const routeName = '/analysis';

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _timer = Timer(const Duration(seconds: 3), _finishAnalysis);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _finishAnalysis() {
    final question = ModalRoute.of(context)?.settings.arguments as String? ?? '';
    Navigator.of(context).pushReplacementNamed(
      ResultScreen.routeName,
      arguments: question,
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = ModalRoute.of(context)?.settings.arguments as String? ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analisando...'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              turns: _controller,
              child: const Icon(
                Icons.radar,
                size: 120,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Processando sinais para identificar a verdade.',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            if (question.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Pergunta: "$question"',
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 32),
            LinearProgressIndicator(
              minHeight: 6,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
