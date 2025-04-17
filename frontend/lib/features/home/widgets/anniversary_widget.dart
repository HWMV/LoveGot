import 'package:flutter/material.dart';
import '../../../shared/widgets/custom_card.dart';

class AnniversaryWidget extends StatelessWidget {
  final int days;
  final String myNickname;
  final String partnerNickname;

  const AnniversaryWidget({
    Key? key,
    required this.days,
    required this.myNickname,
    required this.partnerNickname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      backgroundColor: Colors.pink.shade50,
      child: Column(
        children: [
          Text(
            '사랑한 지 $days일 째',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                myNickname,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Icon(Icons.favorite, color: Colors.red, size: 16),
              ),
              Text(
                partnerNickname,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
