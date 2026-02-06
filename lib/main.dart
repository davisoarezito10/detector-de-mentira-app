import 'package:flutter/material.dart';

import 'screens/marketplace_screen.dart';

void main() {
  runApp(const ObraConfiavelApp());
}

class ObraConfiavelApp extends StatelessWidget {
  const ObraConfiavelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ObraConfiável',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1D4ED8)),
        useMaterial3: true,
      ),
      home: const MarketplaceScreen(),
    );
  }
}
