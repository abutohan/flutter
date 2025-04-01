import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/screens/questions/questions_screen.dart';
import 'package:quiz_app/screens/results/results_screen.dart';
import 'package:quiz_app/screens/start/start_screen.dart';

class QuizController extends StatefulWidget {
  const QuizController({super.key});

  @override
  State<QuizController> createState() {
    return _QuizControllerState();
  }
}

class _QuizControllerState extends State<QuizController> {
  List<String> _selectedAnswers = [];
  Widget? _activeScreen;

  void _switchScreen() {
    setState(() {
      _activeScreen = QuestionsScreen(onSelectAnswer: _chooseAnswer);
    });
  }

  void _chooseAnswer(String answer) {
    _selectedAnswers.add(answer);

    if (_selectedAnswers.length == questions.length) {
      setState(() {
        _activeScreen = ResultsScreen(
          chosenAnswers: _selectedAnswers,
          onRestart: _switchScreen,
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
