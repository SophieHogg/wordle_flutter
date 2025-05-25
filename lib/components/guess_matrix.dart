import 'package:flutter/material.dart';
import 'package:wordle/components/guess.dart';

class GuessMatrix extends StatelessWidget {
  final List<GuessType> guessHistory;

  const GuessMatrix({required this.guessHistory});

  List<List<Color>> get matrixColours {
    return guessHistory.map((guess) {
      return guess.map((guessLetter) {
        return guessLetter.status.colour;
      }).toList();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final guess in matrixColours)
          Row(
            children: [
              for (final letterColour in guess)
                Icon(Icons.square, size: 28, color: letterColour),
            ],
          ),
      ],
    );
  }
}
