class Flashcard {
  String? id;
  String question;
  String answer;

  Flashcard({
    this.id,
    required this.question,
    required this.answer,
  }) {
    id ??= DateTime.now().millisecondsSinceEpoch.toString();
  }
}
