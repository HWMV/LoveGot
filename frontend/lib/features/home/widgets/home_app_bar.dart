import 'package:flutter/material.dart';
import '../../../core/theme/app_decorations.dart';

class HomeAppBar extends StatelessWidget {
  final VoidCallback? onMessageTap;

  const HomeAppBar({
    Key? key,
    this.onMessageTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 232, 220, 202), // 진한 갈색 배경
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.favorite,
                color: Color.fromARGB(255, 139, 126, 116)),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const Text(
            'LoveGot',
            style: TextStyle(
              fontSize: 24,
              color: Color.fromARGB(255, 139, 126, 116),
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.mail_outline,
                color: Color.fromARGB(255, 139, 126, 116)),
            onPressed: onMessageTap,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
