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

  // 화면 이동 처리
  void handleNavigation(BuildContext context, int index) {
    // 현재 선택된 탭과 동일한 경우 처리 안함
    if (selectedIndex == index) return;

    onItemSelected(index);

    switch (index) {
      case 0: // 홈
        if (context.widget.toString() != 'HomeScreen') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
        break;
      case 1: // 커뮤니티
        if (context.widget.toString() != 'CommunityScreen') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const CommunityScreen()),
          );
        }
        break;
      case 2: // 채팅
        // TODO: 채팅 화면 구현 후 이동 처리
        break;
      case 3: // 설정
        // TODO: 설정 화면 구현 후 이동 처리
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // 베이지/브라운 계열 색상 정의
    const Color primaryColor = Color(0xFF8B7055); // 선택된 아이콘 색상 (진한 브라운)
    const Color inactiveColor = Color(0xFFBDA78C); // 비활성 아이콘 색상 (연한 베이지 브라운)

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
              context, 0, Icons.home, '홈', primaryColor, inactiveColor),
          _buildNavItem(
              context, 1, Icons.people, '커뮤니티', primaryColor, inactiveColor),
          _buildNavItem(
              context, 2, Icons.chat_bubble, '', primaryColor, inactiveColor),
          _buildNavItem(
              context, 3, Icons.settings, '', primaryColor, inactiveColor),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon,
      String label, Color primaryColor, Color inactiveColor) {
    final isSelected = selectedIndex == index;
    return InkWell(
      onTap: () => handleNavigation(context, index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? primaryColor : inactiveColor,
            size: 28,
          ),
          const SizedBox(height: 2),
          if (label.isNotEmpty)
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? primaryColor : inactiveColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
        ],
      ),
    );
  }
}
