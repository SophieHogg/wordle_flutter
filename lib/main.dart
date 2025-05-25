import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:wordle/components/future_guesses.dart';
import 'package:wordle/components/guess.dart';
import 'package:wordle/components/guess_history.dart';
import 'package:wordle/components/guess_matrix.dart';
import 'package:wordle/components/keyboard.dart';
import 'package:wordle/components/success_dialog.dart';
import 'package:wordle/letter_status.dart';
import 'package:wordle/utils/valid_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordle',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(title: 'Wordle'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> currentWord = [];

  // TO DO - update this once guessing is implemented
  List<String> validLetters = [];
  List<String> partialLetters = [];
  List<String> invalidLetters = [];

  List<GuessType> allGuesses = [];
  List<GuessLetterType> currentGuess = [];
  bool isFinished = false;
  String errorMessage = '';
  int guessNumber = 0;

  int get guessesRemaining {
    return 6 - guessNumber - 1;
  }

  List<String> get currentGuessAsLetters {
    return currentGuess.map((GuessLetterType letter) {
      return letter.letter;
    }).toList();
  }

  String get currentGuessAsString {
    return currentGuessAsLetters.join('');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewWord();
  }

  void getNewWord() {
    setState(() {
      currentWord = words.sample(1)[0].toUpperCase().split('');
      print(currentWord);
    });
  }

  void restart() {
    setState(() {
      isFinished = false;
      allGuesses = [];
      currentGuess = [];
      validLetters = [];
      invalidLetters = [];
      partialLetters = [];
      guessNumber = 0;
      getNewWord();
    });
  }

  String? getGuessErrors(List<String> guess, List<String> words) {
    if (guess.length != 5) return 'Guess must be 5 letters long';
    final stringGuess = guess.join('').toLowerCase();
    if (!words.contains(stringGuess)) {
      String upperCaseGuess = stringGuess.toUpperCase();
      return '"$upperCaseGuess" is not a valid word.';
    } else {
      return null;
    }
  }

  List<GuessLetterType> getColourCodedGuess(
    List<String> currentWord,
    List<dynamic> guess,
  ) {
    List<String> validLetterList = [];
    guess.forEach((letter) {
      if (letter is GuessLetterType) {
        validLetterList.add(letter.letter);
      }
    });

    return guess.mapIndexed((index, letter) {
      if (letter is GuessLetterType) {
        return letter;
      }

      if (!currentWord.contains(letter)) {
        return GuessLetterType(letter, LetterStatus.invalid);
      }

      if (currentWord.contains(letter) &&
          currentWord[index] != letter &&
          validLetterList.where((l) => letter == l).length ==
              currentWord.where((l) => letter == l).length) {
        return GuessLetterType(letter, LetterStatus.invalid);
      }

      return GuessLetterType(letter, LetterStatus.partial);
    }).toList();
  }

  void addLetterToGuessString(String letter) {
    setState(() {
      if (currentGuess.length == 5) {
        errorMessage = 'You can only guess a five letter word.';
        showErrorSnack(errorMessage);
      }
      if (currentGuess.length < 5) {
        currentGuess.add(GuessLetterType(letter, LetterStatus.unknown));
      }
    });
  }

  void removeLastLetter() {
    setState(() {
      if (currentGuess.isNotEmpty) {
        currentGuess.removeLast();
      }
    });
  }

  List<dynamic> getValidLetters(List<String> currentWord, List<String> guess) {
    return guess.mapIndexed((index, letter) {
      if (currentWord.contains(letter) && currentWord[index] == letter) {
        return GuessLetterType(letter, LetterStatus.valid);
      } else {
        return letter;
      }
    }).toList();
  }

  void showErrorSnack(String guessError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(guessError, style: TextStyle(fontSize: 16))),
    );
  }

  void updateLetterValidity(List<GuessLetterType> colourCodedGuess) {
    colourCodedGuess.forEach((guessLetter) {
      if (guessLetter.status == LetterStatus.valid) {
        validLetters.add(guessLetter.letter);
      } else if (guessLetter.status == LetterStatus.partial) {
        partialLetters.add(guessLetter.letter);
      } else {
        invalidLetters.add(guessLetter.letter);
      }
    });
  }

  Future<void> showFailureDialog() {
    String currentWordAsString = currentWord.join('');
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Woahhh ☹️'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 4.0,
            children: [
              Text(
                'You failed to guess the word "$currentWordAsString" in 6 guesses',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [GuessMatrix(guessHistory: allGuesses)],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () {
                restart();
                Navigator.pop(context);
              },
              child: Text('Try again!'),
            ),
          ],
        );
      },
    );
  }

  Future<void> showSuccessDialog() {
    int guessesTaken = guessNumber + 1;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SuccessDialog(
          onRetry: () {
            restart();
            Navigator.pop(context);
          },
          correctGuess: currentGuessAsString,
          guessesTaken: guessesTaken,
          guessHistory: allGuesses,
        );
      },
    );
  }

  void submitGuess() {
    setState(() {
      // validate
      final String? guessError = getGuessErrors(currentGuessAsLetters, words);
      if (guessError != null) {
        showErrorSnack(guessError);
        return;
      }
      // create colour-coded guess for the matrix
      List<dynamic> interimValidLetters = (getValidLetters(
        currentWord,
        currentGuessAsLetters,
      ));
      final colourCodedCurrentGuess = getColourCodedGuess(
        currentWord,
        interimValidLetters,
      );

      // update knowledge
      updateLetterValidity(colourCodedCurrentGuess);
      allGuesses.add(colourCodedCurrentGuess);
      print('current Word = $currentWord');
      print('currentGuessAsLetters = $currentGuessAsLetters');
      if (currentWord.join('') == currentGuessAsLetters.join('')) {
        showSuccessDialog();
        isFinished = true;
        return;
      }
      if (guessesRemaining != 0) {
        guessNumber += 1;
        currentGuess = [];
      } else {
        showFailureDialog();
        isFinished = true;
      }
    });
  }

  LetterStatus findLetterStatus(String letter) {
    if (validLetters.contains(letter)) return LetterStatus.valid;
    if (partialLetters.contains(letter)) return LetterStatus.partial;
    if (invalidLetters.contains(letter)) return LetterStatus.invalid;
    return LetterStatus.unknown;
  }

  bool get canInputGuesses {
    return guessesRemaining >= 0 && !isFinished;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.blue.shade50,
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 4,
            children: <Widget>[
              if (allGuesses.isNotEmpty) GuessHistory(guessHistory: allGuesses),
              if (canInputGuesses) Guess(guessLetters: currentGuess),
              if (guessesRemaining > 0)
                FutureGuesses(guessesRemaining: guessesRemaining),
              if (canInputGuesses)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Keyboard(
                    validLetters: validLetters,
                    invalidLetters: invalidLetters,
                    partialLetters: partialLetters,
                    onEnter: submitGuess,
                    onKeyboardClick: (letter) => addLetterToGuessString(letter),
                    onBackspace: removeLastLetter,
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        highlightElevation: 0,
        foregroundColor: Colors.blue.shade800,
        backgroundColor: Colors.blue.shade100,
        splashColor: Colors.blue.shade200,
        onPressed: restart,
        tooltip: 'Restart',
        child: const Icon(Icons.restart_alt, size: 36),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
