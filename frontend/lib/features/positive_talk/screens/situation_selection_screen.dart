import 'package:flutter/material.dart';
import '../models/scenario_model.dart';
import '../screens/training_screen.dart';
import '../services/scenario_service.dart';

void showSituationSelectionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Color(0xFFF5EFE6),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '훈련할 대화 상황을 선택해 주세요',
                  style: TextStyle(
                    color: Color(0xFF8B7E74),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                _buildSituationCard(
                  context,
                  title: '연인이 치약을 가운데부터 짰을 때',
                  subtitle: '일상적인 불편 상황',
                  color: Color(0xFFE8DCCA),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const TrainingScreen(scenarioId: '001')),
                    );
                  },
                ),
                const SizedBox(height: 14),
                _buildSituationCard(
                  context,
                  title: '연인이 약속시간에 늦었을 때',
                  subtitle: '매번 데이트마다 늦는 상황',
                  color: Color(0xFFE8DCCA),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const TrainingScreen(scenarioId: '002')),
                    );
                  },
                ),
                const SizedBox(height: 14),
                _buildSituationCard(
                  context,
                  title: '연인이 회식으로 늦게 귀가 했을 때',
                  subtitle: '회식으로 인한 지각 상황',
                  color: Color(0xFFE8DCCA),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const TrainingScreen(scenarioId: '003')),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget _buildSituationCard(
  BuildContext context, {
  required String title,
  required String subtitle,
  required Color color,
  required VoidCallback onTap,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      bool isSelected = false;

      return SizedBox(
        width: double.infinity,
        height: 140,
        child: Card(
          elevation: isSelected ? 8 : 6,
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected ? Colors.pink.shade300 : Colors.white,
              width: isSelected ? 3 : 2,
            ),
          ),
          shadowColor: isSelected ? Colors.pink.shade100 : Colors.black12,
          child: InkWell(
            onTap: () {
              setState(() {
                isSelected = true;
              });
              Future.delayed(const Duration(milliseconds: 200), () {
                onTap();
              });
            },
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF333333),
                      shadows: isSelected
                          ? [
                              Shadow(
                                color: Colors.pink.shade200,
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: const Color(0xFF666666),
                      shadows: isSelected
                          ? [
                              Shadow(
                                color: Colors.pink.shade200,
                                blurRadius: 8,
                                offset: const Offset(0, 1),
                              ),
                            ]
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
