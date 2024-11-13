import 'package:flash_card/Module/FlashCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flip_card/flip_card.dart';
import '../Controller/flashcard_controller.dart';
import 'add_edit_flashcard_dialog.dart';

class FlashcardWidget extends StatelessWidget {
  final Flashcard flashcard;

  FlashcardWidget({required this.flashcard});

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      direction: FlipDirection.HORIZONTAL,
      front: _buildCardSide(
        content: flashcard.question,
        isFront: true,
      ),
      back: _buildCardSide(
        content: flashcard.answer,
        isFront: false,
      ),
    );
  }

  Widget _buildCardSide({required String content, required bool isFront}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isFront
              ? [Theme.of(Get.context!).primaryColorDark, Theme.of(Get.context!).primaryColorLight]
              : [Theme.of(Get.context!).secondaryHeaderColor, Theme.of(Get.context!).primaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: isFront ? Theme.of(Get.context!).primaryColor : Theme.of(Get.context!).secondaryHeaderColor,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: isFront ? Colors.white : Colors.black,
            ),
          ),
          if (isFront) _buildActionRow(),
        ],
      ),
    );
  }

  Widget _buildActionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _iconButton(
          Icons.edit,
          Theme.of(Get.context!).primaryColor,
              () {
            Get.dialog(
              AddEditFlashcardDialog(flashcard: flashcard),
            );
          },
        ),
        SizedBox(width: 8),
        _iconButton(
          Icons.delete,
          Colors.redAccent,
          _showDeleteConfirmation,
        ),
      ],
    );
  }

  Widget _iconButton(IconData icon, Color color, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(Get.context!).primaryColorDark,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: color),
        onPressed: onTap,
      ),
    );
  }

  void _showDeleteConfirmation() {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Delete Flashcard',
          style: TextStyle(
            color: Colors.redAccent,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this flashcard?',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.find<FlashcardController>().deleteFlashcard(flashcard.id!);
              Get.back();
            },
            child: Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}