import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:wordle/components/keyboard.dart';
import 'package:wordle/components/keyboard_letter.dart';

void main() {
  group('Keyboard', () {
    testWidgets('renders all 28 buttons', (tester) async {
      await tester.pumpWidgetBuilder(
        Keyboard(
          onKeyboardClick: (letter) => {},
          onEnter: () => {},
          onBackspace: () => {},
        ),
      );
      final guessLetters = find.byType(KeyboardLetter);
      expect(guessLetters, findsExactly(28));
    });

    testWidgets('triggers onEnter function when enter button is clicked', (
      tester,
    ) async {
      int number = 0;
      await tester.pumpWidgetBuilder(
        Keyboard(
          onKeyboardClick: (letter) => {},
          onEnter: () => {number++},
          onBackspace: () => {number--},
        ),
      );
      final enterFinder = find.text('Enter');
      await tester.tap(enterFinder);
      expect(number, 1);
    });

    testWidgets(
      'triggers onBackspace function when backspace button is clicked',
      (tester) async {
        int number = 0;
        await tester.pumpWidgetBuilder(
          Keyboard(
            onKeyboardClick: (letter) => {},
            onEnter: () => {number++},
            onBackspace: () => {number--},
          ),
        );
        final backspaceFinder = find.text('<-');
        await tester.tap(backspaceFinder);
        expect(number, -1);
      },
    );
    testWidgets(
      'triggers onKeyboardClick function when keyboard button is clicked',
      (tester) async {
        String testLetter = '';
        await tester.pumpWidgetBuilder(
          Keyboard(
            onKeyboardClick: (letter) => {testLetter = letter},
            onEnter: () => {},
            onBackspace: () => {},
          ),
        );
        final letterFinder = find.text('A');
        await tester.tap(letterFinder);
        expect(testLetter, 'A');
      },
    );
  }); // end of group
}
