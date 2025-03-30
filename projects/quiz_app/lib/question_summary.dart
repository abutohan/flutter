import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/question_identifier.dart';

class QuestionSummary extends StatelessWidget {
  const QuestionSummary({required this.summaryData, super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          // children: [
          //   ...summaryData.map((data) {
          //     return Row(children: []);
          //   }),
          // ],
          children:
              summaryData.map((data) {
                return Row(
                  children: [
                    QuestionIdentifier(
                      questionIndex: ((data["question_index"] as int) + 1),
                      isCorrect: data["user_answer"] == data["correct_answer"],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            data["question"] as String,
                            style: GoogleFonts.lato(
                              color: const Color.fromARGB(255, 222, 255, 227),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(data["user_answer"] as String),
                          Text(data["correct_answer"] as String),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
        ),
      ),
    );
  }
}
