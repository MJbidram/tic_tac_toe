import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/home_screen.dart';

void main(List<String> args) {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
