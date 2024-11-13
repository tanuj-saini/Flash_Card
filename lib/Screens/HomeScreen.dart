import 'package:flash_card/Controller/flashcard_controller.dart';
import 'package:flash_card/Module/FlashCard.dart';
import 'package:flash_card/Widget/add_edit_flashcard_dialog.dart';
import 'package:flash_card/Widget/flashcard_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final FlashcardController controller = Get.put(FlashcardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          'Flashcards',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: _buildAddButton(context),
      body: Obx(
            () => controller.flashcards.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          itemCount: controller.flashcards.length,
          itemBuilder: (context, index) {
            final flashcard = controller.flashcards[index];
            return FlashcardWidget(flashcard: flashcard);
          },
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _animateFab(context, scale: 0.95),
      onTapUp: (_) {
        _animateFab(context, scale: 1.0);
        _showAddEditDialog();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).secondaryHeaderColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Icon(Icons.add, size: 28, color: Colors.black87),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text(
        'No flashcards yet',
        style: TextStyle(
          color: Colors.white70,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _animateFab(BuildContext context, {required double scale}) {
    final fab = context.findRenderObject() as RenderBox?;
    if (fab != null) {
      fab.paintBounds.inflate(20);
      fab.markNeedsPaint();
    }
  }

  void _showAddEditDialog([Flashcard? flashcard]) {
    Get.dialog(AddEditFlashcardDialog(flashcard: flashcard));
  }
}