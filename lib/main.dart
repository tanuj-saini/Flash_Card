import 'package:flash_card/Controller/flashcard_controller.dart';
import 'package:flash_card/Module/FlashCard.dart';
import 'package:flash_card/Widget/add_edit_flashcard_dialog.dart';
import 'package:flash_card/Widget/flashcard_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flashcards',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.teal,
        appBarTheme: AppBarTheme(
          color: Colors.teal[800],
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.teal,
        ),
        dialogBackgroundColor: Colors.grey[900],
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final FlashcardController controller = Get.put(FlashcardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcards'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditDialog(),
        child: Icon(Icons.add),
      ),
      body: Obx(
            () => ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: controller.flashcards.length,
          itemBuilder: (context, index) {
            final flashcard = controller.flashcards[index];
            return FlashcardWidget(flashcard: flashcard);
          },
        ),
      ),
    );
  }

  void _showAddEditDialog([Flashcard? flashcard]) {
    Get.dialog(AddEditFlashcardDialog(flashcard: flashcard));
  }
}
