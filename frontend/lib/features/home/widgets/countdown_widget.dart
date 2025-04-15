import 'package:flutter/material.dart';
import '../../../shared/widgets/custom_card.dart';

class CountdownWidget extends StatelessWidget {
  final int daysRemaining;
  final String specialDayName;

  const CountdownWidget({
    Key? key,
    required this.daysRemaining,
    required this.specialDayName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '다음 기념일까지',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$specialDayName : D-$daysRemaining 남음',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
