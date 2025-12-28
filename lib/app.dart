import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'pages/root_page.dart';

class TrigoApp extends StatelessWidget {
  const TrigoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trigo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const RootPage(),
    );
  }
}
