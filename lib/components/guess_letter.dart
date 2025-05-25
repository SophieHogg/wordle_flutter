import 'package:flutter/material.dart';
import 'package:wordle/letter_status.dart';

class GuessLetter extends StatelessWidget {
  final String letter;
  final LetterStatus status;

  const GuessLetter({this.letter = '', this.status = LetterStatus.unknown});

  Color get guessLetterBackgroundColour {
    if (letter == '') {
      return Colors.black45;
    } else {
      return status.colour;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: guessLetterBackgroundColour,
        ),
        child: Container(
          padding: EdgeInsetsGeometry.all(12),
          child: Center(
            child: Text(
              letter,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 36,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
