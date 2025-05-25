import 'package:flutter/material.dart';

enum LetterStatus {
  unknown, // not guessed yet
  invalid, // guessed, not in the word
  partial, // guessed, in the word, not in the right spot
  valid; // guessed, in the word, in the right spot

  Color get colour {
    return switch (this) {
      LetterStatus.unknown => Colors.black,
      LetterStatus.invalid => Colors.black54,
      LetterStatus.partial => Colors.orange.shade800,
      LetterStatus.valid => Colors.green.shade700,
    };
  }
}
