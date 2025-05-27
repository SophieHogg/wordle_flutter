import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:wordle/components/guess_letter.dart';
import 'package:wordle/letter_status.dart';

void main() {
  testWidgets('Widget renders empty string if no props are passed', (
    tester,
  ) async {
    await tester.pumpWidgetBuilder(GuessLetter());
    final letterFinder = find.byType(Text);
    expect(letterFinder, findsOneWidget);
    final textWidget = tester.widget<Text>(find.byType(Text));
    expect(textWidget.data, '');
  });

  Widget buildGuessLetter(LetterStatus status) {
    // prevent widget from overflowing as a result of aspect ratio
    return SizedBox(
      width: 100,
      child: GuessLetter(letter: 'X', status: status, isCurrent: false),
    );
  }

  testGoldens('GuessLetter should look correct for each status', (
    tester,
  ) async {
    final builder = GoldenBuilder.grid(columns: 2, widthToHeightRatio: 1)
      ..addScenario('Unknown', buildGuessLetter(LetterStatus.unknown))
      ..addScenario('Valid', buildGuessLetter(LetterStatus.valid))
      ..addScenario('Partial', buildGuessLetter(LetterStatus.partial))
      ..addScenario('Invalid', buildGuessLetter(LetterStatus.invalid));
    await tester.pumpWidgetBuilder(builder.build());
    await screenMatchesGolden(tester, 'guess_letter_grid');
  });
}
