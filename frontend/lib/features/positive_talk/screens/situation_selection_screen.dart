import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/scenario_model.dart';
import '../screens/training_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SituationSelectionScreen extends StatelessWidget {
  const SituationSelectionScreen({Key? key}) : super(key: key);

  Future<List<Scenario>> _fetchScenarios() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        print('❌ 유저가 인증되지 않았습니다. Firestore에 접근할 수 없습니다.');
        return [];
      }

      final snapshot =
          await FirebaseFirestore.instance.collection('scenarios').get();

      if (snapshot.docs.isEmpty) {
        print('⚠️ No scenarios found in Firestore');
        return [];
      }

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Scenario.fromMap(data);
      }).toList();
    } catch (e) {
      print('❌ Firebase fetch error: $e');
      print('❌ Error details: ${e.toString()}');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        height: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '훈련할 대화 상황을 선택해주세요',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Scenario>>(
                future: _fetchScenarios(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    print('❌ Firebase fetch error: ${snapshot.error}');
                    return Center(child: Text('에러 발생: ${snapshot.error}'));
                  }

                  final scenarios = snapshot.data ?? [];

                  return ListView.builder(
                    itemCount: scenarios.length,
                    itemBuilder: (context, index) {
                      final scenario = scenarios[index];
                      return _buildScenarioCard(context, scenario);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScenarioCard(BuildContext context, Scenario scenario) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // 다이얼로그 닫기
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TrainingScreen(scenario: scenario),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 8),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.chat_bubble_outline, color: Colors.pink),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      scenario.id + '. ' + scenario.prompt,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
