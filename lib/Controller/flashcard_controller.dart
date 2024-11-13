import 'package:flash_card/Module/FlashCard.dart';
import 'package:get/get.dart';

class FlashcardController extends GetxController {
  var flashcards = <Flashcard>[].obs;

  void addFlashcard(Flashcard flashcard) {
    flashcards.add(flashcard);
  }

  void updateFlashcard(Flashcard flashcard) {
    final index =
        flashcards.indexWhere((element) => element.id == flashcard.id);
    if (index != -1) {
      flashcards[index] = flashcard;
    }
  }

  void deleteFlashcard(String id) {
    flashcards.removeWhere((flashcard) => flashcard.id == id);
  }
}
