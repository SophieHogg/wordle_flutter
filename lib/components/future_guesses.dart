import 'package:flutter/material.dart';
import 'package:wordle/components/guess.dart';

class FutureGuesses extends StatelessWidget {
  final int guessesRemaining;

  const FutureGuesses({required this.guessesRemaining});

  static final List<GuessLetterType> _emptyGuess = List.filled(
    5,
    Guess.emptyGuessLetter,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        for (final guess in List.filled(guessesRemaining, _emptyGuess))
          Guess(guessLetters: guess),
      ],
    );
  }
}
