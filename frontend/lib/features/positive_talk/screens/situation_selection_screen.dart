import 'package:flutter/material.dart';
import 'training_screen.dart';

class SituationSelectionScreen extends StatelessWidget {
  const SituationSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '훈련할 대화 상황을 선택해주세요',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 24),
            _buildSituationCard(
              context,
              '연인이 회식으로 늦게 귀가 했을 때',
              '회식으로 인한 지각 상황',
              Icons.nightlife,
            ),
            const SizedBox(height: 16),
            _buildSituationCard(
              context,
              '연락을 잘 받지 않았을 때',
              '연락이 닿지 않는 상황',
              Icons.phone_missed,
            ),
            const SizedBox(height: 16),
            _buildSituationCard(
              context,
              '연인이 치약을 가운데부터 짰을 때',
              '일상적인 불편 상황',
              Icons.cleaning_services,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSituationCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pop(context); // 현재 다이얼로그 닫기
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TrainingScreen(situation: title),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF5F7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFFFF8FA3),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFFCCCCCC),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
