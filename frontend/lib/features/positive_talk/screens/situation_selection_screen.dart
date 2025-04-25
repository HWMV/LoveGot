import 'package:flutter/material.dart';
import '../models/scenario_model.dart';
import '../screens/training_screen.dart';
import '../services/scenario_service.dart';

class SituationSelectionScreen extends StatelessWidget {
  const SituationSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF333333)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '훈련할 대화 상황을 선택해 주세요',
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSituationCard(
                    context,
                    title: '연인이 치약을 가운데부터 짰을 때',
                    subtitle: '일상적인 불편 상황',
                    color: const Color(0xFFFFD1DC),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const TrainingScreen(scenarioId: '001'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 14),
                  _buildSituationCard(
                    context,
                    title: '연인이 약속시간에 늦었을 때',
                    subtitle: '매번 데이트마다 늦는 상황',
                    color: const Color(0xFFB5EAD7),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const TrainingScreen(scenarioId: '002'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 14),
                  _buildSituationCard(
                    context,
                    title: '연인이 회식으로 늦게 귀가 했을 때',
                    subtitle: '회식으로 인한 지각 상황',
                    color: const Color(0xFFC7CEEA),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const TrainingScreen(scenarioId: '003'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSituationCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
