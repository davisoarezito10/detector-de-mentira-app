import 'package:flutter/material.dart';

import 'screens/analysis_screen.dart';
import 'screens/home_screen.dart';
import 'screens/question_screen.dart';
import 'screens/result_screen.dart';

void main() {
  runApp(const DetectorDeMentiraApp());
}

class DetectorDeMentiraApp extends StatelessWidget {
  const DetectorDeMentiraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detector de Mentira',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5D2EFF)),
        useMaterial3: true,
      ),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        QuestionScreen.routeName: (context) => const QuestionScreen(),
        AnalysisScreen.routeName: (context) => const AnalysisScreen(),
        ResultScreen.routeName: (context) => const ResultScreen(),
      },
    );
  }
}
