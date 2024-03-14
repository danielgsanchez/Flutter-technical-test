import 'package:flutter/material.dart';

import '/config/theme/themedata.dart';
import '/features/choose_country/presentation/pages/home_screen.dart';
import 'injection_container.dart';

void main() {
  setupDependencies(); // This will initialize the cubits needed for the app, among other things
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoccerInfo',
      theme: theme(),
      home: const HomeScreen(),
    );
  }
}
