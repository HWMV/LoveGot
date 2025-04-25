import 'package:flutter/material.dart';
import '../../features/positive_talk/screens/positive_talk_screen.dart';
import '../../features/community/screens/community_screen.dart';
import '../../features/home/screens/home_screen.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.home, 'Home', context),
            _buildNavItem(1, Icons.chat_bubble_outline, 'Community', context),
            _buildNavItem(2, Icons.calendar_today, 'Coaching', context),
            _buildNavItem(3, Icons.person_outline, 'Profile', context),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
      int index, IconData icon, String label, BuildContext context) {
    final bool isSelected = index == selectedIndex;
    return InkWell(
      onTap: () {
        if (index == 2) {
          // Coaching 버튼
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PositiveTalkScreen(),
            ),
          );
        } else if (index == 1) {
          // Community 버튼
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CommunityScreen(),
            ),
          );
        } else if (index == 0) {
          // Home 버튼
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        } else {
          onItemSelected(index);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.black : Colors.grey,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
