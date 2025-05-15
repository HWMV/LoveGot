import 'package:flutter/material.dart';

class BalanceResultView extends StatelessWidget {
  final double option1Percentage;
  final double option2Percentage;
  final int partnerOption;
  final int selectedOption;

  const BalanceResultView({
    Key? key,
    required this.option1Percentage,
    required this.option2Percentage,
    required this.partnerOption,
    required this.selectedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: (option1Percentage * 10).round(),
              child: Container(
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFF8B7E74),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '1번 ${option1Percentage.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: (option2Percentage * 10).round(),
              child: Container(
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFB0B0B0),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '2번 ${option2Percentage.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFF5EFE6),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            '👫 연인의 선택 답변 : ${partnerOption}번',
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFF5EFE6),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            '🧍 당신의 선택 답변 : ${selectedOption}번',
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
