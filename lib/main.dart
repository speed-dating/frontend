import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:speed_dating_front/authentication/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: FlexThemeData.light(scheme: FlexScheme.redM3),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.redM3),
      home: const WelcomeScreen(),
    );
  }
}
