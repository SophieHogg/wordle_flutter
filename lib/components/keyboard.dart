import 'package:flutter/material.dart';
import 'package:wordle/components/keyboard_letter.dart';
import 'package:wordle/letter_status.dart';

class Keyboard extends StatelessWidget {
  final List<String> validLetters;
  final List<String> partialLetters;
  final List<String> invalidLetters;
  final void Function(String letter) onKeyboardClick;
  final VoidCallback onEnter;
  final VoidCallback onBackspace;

  const Keyboard({
    required this.onKeyboardClick,
    required this.onEnter,
    required this.onBackspace,
    this.validLetters = const [],
    this.invalidLetters = const [],
    this.partialLetters = const [],
  });

  static const firstRowLetters = [
    'Q',
    'W',
    'E',
    'R',
    'T',
    'Y',
    'U',
    'I',
    'O',
    'P',
  ];
  static const secondRowLetters = ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'];
  static const thirdRowLetters = ['Z', 'X', 'C', 'V', 'B', 'N', 'M'];

  LetterStatus findLetterStatus(String letter) {
    if (validLetters.contains(letter)) return LetterStatus.valid;
    if (partialLetters.contains(letter)) return LetterStatus.partial;
    if (invalidLetters.contains(letter)) return LetterStatus.invalid;
    return LetterStatus.unknown;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final letter in firstRowLetters)
              KeyboardLetter(
                letter: letter,
                status: findLetterStatus(letter),
                onLetterClick: () => onKeyboardClick(letter),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final letter in secondRowLetters)
              KeyboardLetter(
                letter: letter,
                status: findLetterStatus(letter),
                onLetterClick: () => onKeyboardClick(letter),
              ),
            KeyboardLetter(
              letter: '<-',
              status: LetterStatus.unknown,
              onLetterClick: onBackspace,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final letter in thirdRowLetters)
              KeyboardLetter(
                letter: letter,
                status: findLetterStatus(letter),
                onLetterClick: () => onKeyboardClick(letter),
              ),
            KeyboardLetter(
              letter: 'Enter',
              status: LetterStatus.unknown,
              onLetterClick: onEnter,
            ),
          ],
        ),
      ],
    );
  }
}
