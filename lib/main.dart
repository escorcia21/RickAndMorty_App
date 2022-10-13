import 'package:flutter/material.dart';
import 'package:rickandmorty/screens/content.screen.dart';
import 'package:rickandmorty/theme/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "This is't a rick and morty app",
      theme: MyTheme.darkTheme,
      home: const ContentScreen(),
    );
  }
}
