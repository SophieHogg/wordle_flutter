import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:wordle/components/guess.dart';
import 'package:wordle/components/guess_letter.dart';
import 'package:wordle/letter_status.dart';

void main() {
  List<GuessLetterType> sampleGuess = [
    GuessLetterType('S', LetterStatus.unknown),
    GuessLetterType('H', LetterStatus.unknown),
    GuessLetterType('O', LetterStatus.unknown),
    GuessLetterType('R', LetterStatus.unknown),
    GuessLetterType('T', LetterStatus.unknown),
  ];

  List<String> sampleGuessAsLetters = ['S', 'H', 'O', 'R', 'T'];

  group('Guess Widget', () {
    testWidgets('should fill out empty array with empty guesses', (
      tester,
    ) async {
      await tester.pumpWidgetBuilder(Guess(guessLetters: []));
      final guessLetters = find.byType(GuessLetter);
      expect(guessLetters, findsExactly(5));
    });

    testWidgets('should render given array of letters', (tester) async {
      await tester.pumpWidgetBuilder(Guess(guessLetters: sampleGuess));
      final guessLetters = find.byType(GuessLetter);
      expect(guessLetters, findsExactly(5));
      for (final letter in sampleGuessAsLetters) {
        expect(find.text(letter), findsOneWidget);
      }
    });
  });
}
