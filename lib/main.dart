import 'package:flutter/material.dart';
import 'package:nutria/Screens/Profile%20and%20user%20info/ProfileScreen.dart';
import 'package:nutria/Screens/Profile%20and%20user%20info/ProfileScreenBuilder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: ProfileScreenBuilder(), //calling the widgets here
      ),
    );
  }
}
