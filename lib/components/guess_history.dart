import 'package:flutter/material.dart';
import 'package:wordle/components/guess.dart';

class GuessHistory extends StatelessWidget {
  final List<GuessType> guessHistory;

  const GuessHistory({required this.guessHistory});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [for (final guess in guessHistory) Guess(guessLetters: guess)],
    );
  }
}
