import 'package:flutter/material.dart';

class BalanceResultView extends StatelessWidget {
  final int selectedOption;
  final int partnerOption;
  final double option1Percentage;
  final double option2Percentage;

  const BalanceResultView({
    Key? key,
    required this.selectedOption,
    required this.partnerOption,
    required this.option1Percentage,
    required this.option2Percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '결과',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        _buildResultBar(
          context,
          option: 1,
          percentage: option1Percentage,
          isSelected: selectedOption == 1,
          isPartnerSelected: partnerOption == 1,
        ),
        const SizedBox(height: 16),
        _buildResultBar(
          context,
          option: 2,
          percentage: option2Percentage,
          isSelected: selectedOption == 2,
          isPartnerSelected: partnerOption == 2,
        ),
        const SizedBox(height: 24),
        _buildResultMessage(),
        const Spacer(),
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              '다른 밸런스 게임 하기',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultBar(
    BuildContext context, {
    required int option,
    required double percentage,
    required bool isSelected,
    required bool isPartnerSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          option == 1 ? '9시에 업무 시작이다' : '9시까지 출근해도 된다!',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Pretendard',
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Theme.of(context).primaryColor : Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            FractionallySizedBox(
              widthFactor: percentage / 100,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '${percentage.toStringAsFixed(1)}%',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Epilogue',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            if (isSelected || isPartnerSelected)
              Positioned(
                right: 12,
                top: 8,
                child: Row(
                  children: [
                    if (isSelected)
                      const Icon(Icons.person, color: Colors.blue),
                    if (isPartnerSelected)
                      const Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Icon(Icons.favorite, color: Colors.red),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildResultMessage() {
    final bool sameChoice = selectedOption == partnerOption;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: sameChoice ? Colors.blue[50] : Colors.orange[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        sameChoice ? '상대방과 같은 선택을 하셨네요! 🎉' : '상대방과 다른 선택을 하셨네요! 🤔',
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w500,
          color: sameChoice ? Colors.blue[900] : Colors.orange[900],
        ),
      ),
    );
  }
}
