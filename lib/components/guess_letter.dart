import 'package:flutter/material.dart';
import 'package:wordle/letter_status.dart';

class GuessLetter extends StatelessWidget {
  final String letter;
  final LetterStatus status;
  final bool isCurrent;

  const GuessLetter({
    this.letter = '',
    this.status = LetterStatus.unknown,
    this.isCurrent = false,
  });

  Color get _guessLetterBackgroundColour {
    if (letter == '') {
      return Colors.black45;
    } else {
      return status.colour;
    }
  }

  double get borderRadius {
    if (isCurrent && letter != '') {
      return 30;
    } else {
      return 12;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          color: _guessLetterBackgroundColour,
        ),
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
    );
  }
}
