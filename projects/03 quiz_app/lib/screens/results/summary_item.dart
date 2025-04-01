import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/screens/results/question_identifier.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem({required this.itemData, super.key});

  final Map<String, Object> itemData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionIdentifier(
            questionIndex: ((itemData["question_index"] as int) + 1),
            isCorrect: itemData["user_answer"] == itemData["correct_answer"],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemData["question"] as String,
                  style: GoogleFonts.lato(
                    color: const Color.fromARGB(255, 222, 255, 227),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  itemData["user_answer"] as String,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 118, 236, 128),
                  ),
                ),
                Text(
                  itemData["correct_answer"] as String,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 194, 101, 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
