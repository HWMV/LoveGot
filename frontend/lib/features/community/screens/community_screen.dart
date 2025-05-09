import 'package:flutter/material.dart';
import '../../../shared/widgets/bottom_nav_bar.dart';
import '../../home/screens/home_screen.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  int _selectedIndex = 1; // Community tab index

  // 베이지 계열 색상 정의 (홈 화면과 동일)
  static const Color primaryBeigeColor = Color(0xFFF5EFE6); // 밝은 베이지 (배경색)
  static const Color secondaryBeigeColor = Color(0xFFE8DCCA); // 중간 베이지 (섹션 배경)
  static const Color accentBeigeColor = Color(0xFFD4C2A8); // 진한 베이지 (액센트)
  static const Color brownColor = Color(0xFF8B7E74); // 갈색 (포인트 색상)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBeigeColor,
      appBar: AppBar(
        backgroundColor: secondaryBeigeColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: brownColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          '커뮤니티',
          style: TextStyle(
            color: brownColor,
            fontSize: 20,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: brownColor),
            onPressed: () {
              // TODO: Implement post creation
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 투표 현황 위젯
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: secondaryBeigeColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '⏰ 아침형 인간 vs 저녁형 인간',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.bold,
                    color: brownColor,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: primaryBeigeColor,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 30,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(20)),
                            color: accentBeigeColor,
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '30%',
                            style: TextStyle(
                              color: brownColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 70,
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            '70%',
                            style: TextStyle(
                              color: brownColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '응답자: 709명',
                  style: TextStyle(
                    fontSize: 14,
                    color: brownColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: secondaryBeigeColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '🌅 아침 9시까지 출근 vs 9시에 업무 시작',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.bold,
                    color: brownColor,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: primaryBeigeColor,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 45,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(20)),
                            color: accentBeigeColor,
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '45%',
                            style: TextStyle(
                              color: brownColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 55,
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            '55%',
                            style: TextStyle(
                              color: brownColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '응답자: 512명',
                  style: TextStyle(
                    fontSize: 14,
                    color: brownColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: secondaryBeigeColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '🍽️ 밥 먹고 바로 설거지하기 vs 조금 쉬었다가 집안일 몰아서 하기',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.bold,
                    color: brownColor,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: primaryBeigeColor,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 60,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(20)),
                            color: accentBeigeColor,
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '60%',
                            style: TextStyle(
                              color: brownColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 40,
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            '40%',
                            style: TextStyle(
                              color: brownColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '응답자: 423명',
                  style: TextStyle(
                    fontSize: 14,
                    color: brownColor,
                  ),
                ),
              ],
            ),
          ),

          // 더 많은 투표를 보려면
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () {
                // TODO: 더 많은 투표 화면으로 이동
              },
              style: TextButton.styleFrom(
                foregroundColor: brownColor,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '더 많은 투표 보기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
          ),

          // 댓글 섹션
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primaryBeigeColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: 0, // TODO: Implement actual comments
                      itemBuilder: (context, index) {
                        return const SizedBox(); // Placeholder
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: accentBeigeColor,
        onPressed: () {
          // TODO: Implement post creation navigation
        },
        child: Icon(Icons.add, color: brownColor),
      ),
    );
  }
}
