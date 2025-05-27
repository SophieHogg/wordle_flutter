import 'package:flutter/material.dart';
import 'package:wordle/components/guess.dart';
import 'package:wordle/components/guess_matrix.dart';

class FailureDialog extends StatelessWidget {
  final void Function() onRetry;
  final void Function() onClose;
  final String correctWord;
  final List<GuessType> guessHistory;

  const FailureDialog({
    required this.onRetry,
    required this.onClose,
    required this.correctWord,
    this.guessHistory = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Woahhh ☹️'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 4.0,
        children: [
          Image(image: AssetImage('assets/crash-bandicoot-woah-sad.gif')),
          Text(
            'You failed to guess the word "$correctWord" in 6 guesses.',
            style: TextStyle(fontSize: 16),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [GuessMatrix(guessHistory: guessHistory)],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            onClose();
          },
          child: Text('Close', style: TextStyle(fontSize: 18)),
        ),
        TextButton(
          onPressed: () {
            onRetry();
          },
          child: Text('Try again!', style: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }
}
