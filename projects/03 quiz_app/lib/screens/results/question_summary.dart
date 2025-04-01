import 'package:flutter/material.dart';
import 'package:quiz_app/screens/results/summary_item.dart';

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
                return SummaryItem(itemData: data);
              }).toList(),
        ),
      ),
    );
  }
}
