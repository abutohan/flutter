import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/results_screen.dart';
import 'package:quiz_app/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> _selectedAnswers = [];

  Widget? _activeScreen;

  void _switchScreen() {
    setState(() {
      _activeScreen = QuestionsScreen(onSelectAnswer: _choosedAnswer);
    });
  }

  void _choosedAnswer(String answer) {
    _selectedAnswers.add(answer);

    if (_selectedAnswers.length == questions.length) {
      setState(() {
        _activeScreen = ResultsScreen(
          chosenAnswers: _selectedAnswers,
          startQuiz: _switchScreen,
        );
        _selectedAnswers = [];
      });
    }
  }

  @override
  void initState() {
    _activeScreen = StartScreen(startQuiz: _switchScreen);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Color.fromARGB(255, 143, 185, 145)),
          child: _activeScreen,
        ),
      ),
    );
  }
}
