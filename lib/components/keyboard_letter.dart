import 'package:flutter/material.dart';
import 'package:wordle/letter_status.dart';

class KeyboardLetter extends StatelessWidget {
  final String letter;
  final LetterStatus status;
  final VoidCallback onLetterClick;

  const KeyboardLetter({
    required this.letter,
    required this.onLetterClick,
    this.status = LetterStatus.unknown,
  });

  void printLetter() {
    print(letter);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: status.colour,
      child: InkWell(
        onTap: onLetterClick,
        child: Container(
          padding: EdgeInsetsGeometry.all(12),
          child: Text(
            letter,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
