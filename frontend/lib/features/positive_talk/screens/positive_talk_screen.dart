import 'package:flutter/material.dart';
import '../models/scenario_model.dart';
import '../services/scenario_service.dart';
import 'training_screen.dart';
import 'situation_selection_screen.dart';

class PositiveTalkScreen extends StatelessWidget {
  const PositiveTalkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5EFE6),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 232, 220, 202),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFF5EFE6)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          '긍정 대화법 연습',
          style: TextStyle(
            color: Color.fromARGB(255, 139, 126, 116),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '훈련을 시작해볼까요?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '긍정적인 대화법을 통해\n더 나은 관계를 만들어보세요',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    showSituationSelectionDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE8DCCA),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    '시작하기',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 139, 126, 116),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
