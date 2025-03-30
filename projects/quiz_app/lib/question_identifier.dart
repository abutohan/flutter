import 'package:flutter/material.dart';

class QuestionIdentifier extends StatelessWidget {
  const QuestionIdentifier({
    required this.isCorrect,
    required this.questionIndex,
    super.key,
  });

  final bool isCorrect;
  final int questionIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color:
            isCorrect
                ? Color.fromARGB(255, 88, 233, 83)
                : Color.fromARGB(255, 240, 129, 95),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        questionIndex.toString(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 27, 29, 27),
        ),
      ),
    );
  }
}
