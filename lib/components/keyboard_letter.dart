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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.all(1),
      child: Material(
        child: Ink(
          decoration: BoxDecoration(
            color: status.colour,
            borderRadius: BorderRadius.circular(4),
          ),

          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onLetterClick,
            child: Container(
              padding: EdgeInsetsGeometry.all(10),
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
        ),
      ),
    );
  }
}
