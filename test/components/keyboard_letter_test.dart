import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:wordle/components/keyboard_letter.dart';
import 'package:wordle/letter_status.dart';

void main() {
  testWidgets('Widget takes in and renders passed letter', (tester) async {
    await tester.pumpWidgetBuilder(
      KeyboardLetter(letter: 'X', onLetterClick: () => {}),
    );
    final letterFinder = find.text('X');
    expect(letterFinder, findsOneWidget);
  });

  KeyboardLetter buildKeyboardLetter(LetterStatus status) {
    return KeyboardLetter(letter: 'X', status: status, onLetterClick: () {});
  }

  testGoldens('Keyboard letter should look correct for each status', (
    tester,
  ) async {
    final builder = GoldenBuilder.grid(columns: 2, widthToHeightRatio: 1)
      ..addScenario('Unknown', buildKeyboardLetter(LetterStatus.unknown))
      ..addScenario('Valid', buildKeyboardLetter(LetterStatus.valid))
      ..addScenario('Partial', buildKeyboardLetter(LetterStatus.partial))
      ..addScenario('Invalid', buildKeyboardLetter(LetterStatus.invalid));
    await tester.pumpWidgetBuilder(builder.build());
    await screenMatchesGolden(tester, 'keyboard_letter_grid');
  });

  testWidgets('Widget calls passed function when letter is clicked', (
    tester,
  ) async {
    int number = 0;
    await tester.pumpWidgetBuilder(
      KeyboardLetter(letter: 'X', onLetterClick: () => {number++}),
    );
    final letterFinder = find.text('X');
    await tester.tap(letterFinder);
    expect(number, 1);
  });
}
