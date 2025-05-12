import 'package:flutter/material.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/couple_avatar_widget.dart';
import '../../../shared/widgets/bottom_nav_bar.dart';
import '../../request_card/screens/request_modal.dart';
import '../widgets/compliment_dialog.dart';
import '../widgets/function_card_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Sample data (would be fetched from backend in a real app)
  final DateTime anniversaryDate = DateTime(2025, 1, 1);
  final String myNickname = "나";
  final String partnerNickname = "연인";
  final DateTime nextSpecialDay = DateTime(2025, 1, 1);
  final String specialDayName = "기념일";
  int _selectedIndex = 0;
  bool _isSheetExpanded = false;

  // 앱 전체에서 사용할 베이지 계열 색상 정의
  static const Color primaryBeigeColor = Color(0xFFF5EFE6); // 밝은 베이지 (배경색)
  static const Color secondaryBeigeColor = Color(0xFFE8DCCA); // 중간 베이지 (섹션 배경)
  static const Color accentBeigeColor = Color(0xFFD4C2A8); // 진한 베이지 (액센트)
  static const Color brownColor = Color(0xFF8B7E74); // 갈색 (포인트 색상)

  Future<void> _showRequestDialog() async {
    final result = await showDialog(
      context: context,
      builder: (context) => const RequestDialog(),
    );

    if (result != null) {
      // TODO: Handle the selected request
      print('Original: ${result['original']}');
      print('Improved: ${result['improved']}');
    }
  }

  Future<void> _showComplimentDialog() async {
    final result = await showDialog(
      context: context,
      builder: (context) => const ComplimentDialog(),
    );

    if (result != null) {
      // TODO: Handle the compliment
      print('Compliment: ${result['compliment']}');
    }
  }

  // Future<void> _toggleSheet() {
  //   setState(() {
  //     _isSheetExpanded = !_isSheetExpanded;
  //   });
  //   return Future.value();
  // }

  // 하단 네비게이션 탭 선택 시 현재 선택된 인덱스만 업데이트
  void _updateSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBeigeColor,
      body: SafeArea(
        child: Stack(
          children: [
            // Background and avatar
            Column(
              children: [
                HomeAppBar(
                  onMessageTap: _showRequestDialog,
                ),
                Expanded(
                  child: Container(
                    color: secondaryBeigeColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CoupleAvatarWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // 기능 카드 시트
            Positioned(
              bottom: 64, // 네비게이션 바 위에 위치
              left: 0,
              right: 0,
              child: FunctionCardSheet(
                brownColor: brownColor,
              ),
            ),

            // Bottom Navigation
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomNavBar(
                selectedIndex: _selectedIndex,
                onItemSelected: _updateSelectedIndex,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
