import 'package:flutter/material.dart';
import 'package:wordle/components/guess_letter.dart';
import 'package:wordle/letter_status.dart';

class GuessLetterType {
  final String letter;
  final LetterStatus status;

  const GuessLetterType(this.letter, this.status);
}

typedef GuessType = List<GuessLetterType>;

class Guess extends StatelessWidget {
  final List<GuessLetterType> guessLetters;
  final bool isCurrent;

  const Guess({required this.guessLetters, this.isCurrent = false});

  static const GuessLetterType emptyGuessLetter = GuessLetterType(
    '',
    LetterStatus.unknown,
  );

  List<GuessLetterType> get _interimGuessLetters {
    return List.generate(
      5,
      (i) => guessLetters.elementAtOrNull(i) ?? emptyGuessLetter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final guessLetter in _interimGuessLetters)
          Expanded(
            child: GuessLetter(
              letter: guessLetter.letter,
              status: guessLetter.status,
              isCurrent: isCurrent,
            ),
          ),
      ],
    );
  }
}
