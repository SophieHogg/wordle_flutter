import 'package:flutter/material.dart';
import 'package:wordle/components/guess.dart';
import 'package:wordle/components/guess_matrix.dart';

class SuccessDialog extends StatelessWidget {
  final void Function() onRetry;
  final String correctGuess;
  final List<GuessType> guessHistory;
  final int guessesTaken;

  const SuccessDialog({
    required this.onRetry,
    required this.correctGuess,
    required this.guessesTaken,
    this.guessHistory = const [],
  });

  String get guessWord {
    return guessesTaken > 1 ? 'guesses' : 'guess';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Congratulations!'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          Text(
            'You guessed the word "$correctGuess" in $guessesTaken $guessWord.',
            style: TextStyle(fontSize: 16),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [GuessMatrix(guessHistory: guessHistory)],
          ),
          // matrix
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            onRetry();
          },
          child: const Text('Play again', style: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }
}
