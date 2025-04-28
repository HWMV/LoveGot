import 'package:flutter/material.dart';

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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.pink.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '$myNickname ❤️ $partnerNickname',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '함께한 지 $days일',
                  style: TextStyle(
                    fontFamily: 'Pretendard-Regular',
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
