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
      decoration: AppDecorations.appBarDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.black),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const Text(
            'LoveGott',
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.mail_outline, color: Colors.black),
            onPressed: onMessageTap,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
