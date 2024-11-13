import 'package:flash_card/Controller/flashcard_controller.dart';
import 'package:flash_card/Module/FlashCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEditFlashcardDialog extends StatefulWidget {
  final Flashcard? flashcard;

  AddEditFlashcardDialog({this.flashcard});

  @override
  _AddEditFlashcardDialogState createState() => _AddEditFlashcardDialogState();
}

class _AddEditFlashcardDialogState extends State<AddEditFlashcardDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _questionController;
  late TextEditingController _answerController;
  late FocusNode _questionFocusNode;
  late FocusNode _answerFocusNode;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(text: widget.flashcard?.question);
    _answerController = TextEditingController(text: widget.flashcard?.answer);
    _questionFocusNode = FocusNode();
    _answerFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.flashcard == null ? 'Add Flashcard' : 'Edit Flashcard',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField(_questionController, 'Question', _questionFocusNode),
            SizedBox(height: 16),
            _buildTextField(_answerController, 'Answer', _answerFocusNode),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('Cancel', style: TextStyle(color: Colors.white70)),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).primaryColor,
          ),
        ),
        ElevatedButton(
          onPressed: _saveFlashcard,
          child: Text('Save', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label,
      FocusNode focusNode,
      ) {
    return AnimatedBuilder(
      animation: focusNode,
      builder: (context, child) {
        final borderColor =
        focusNode.hasFocus ? Theme.of(context).primaryColor : Colors.grey;
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: borderColor),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter $label';
            }
            return null;
          },
        );
      },
    );
  }

  void _saveFlashcard() {
    if (_formKey.currentState!.validate()) {
      final controller = Get.find<FlashcardController>();
      final flashcard = Flashcard(
        id: widget.flashcard?.id,
        question: _questionController.text,
        answer: _answerController.text,
      );

      if (widget.flashcard == null) {
        controller.addFlashcard(flashcard);
      } else {
        controller.updateFlashcard(flashcard);
      }

      Get.back();
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    _questionFocusNode.dispose();
    _answerFocusNode.dispose();
    super.dispose();
  }
}