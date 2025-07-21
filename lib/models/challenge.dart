class Challenge {
  final String id;
  final String title;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final int xp;
  final String explanation;

  const Challenge({
    required this.id,
    required this.title,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.xp,
    required this.explanation,
  });
}