class QuizQuestions {
  QuizQuestions({required this.text, required this.answers});
  final String text;
  final List<String> answers;

  List<String> getShuffledAnswers() {
    final List<String> shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}
