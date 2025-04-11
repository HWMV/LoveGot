import 'package:flutter/material.dart';
import '../../../widgets/custom_card.dart';

class AffectionLevelWidget extends StatelessWidget {
  final int affectionLevel;

  const AffectionLevelWidget({
    Key? key,
    required this.affectionLevel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '애정도 $affectionLevel%',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: affectionLevel / 100,
              backgroundColor: Colors.pink.shade100,
              color: Colors.pink.shade400,
              minHeight: 12,
            ),
          ),
        ],
      ),
    );
  }
}
