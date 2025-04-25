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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF333333)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          '커뮤니티',
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 20,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Color(0xFF333333)),
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
              color: Colors.white,
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
                  '⏰ 저녁에 출근 vs 아침에 출근',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFFF5F5F5),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 30,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(20)),
                            color: Colors.red.shade200,
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '30%',
                            style: TextStyle(
                              color: Colors.white,
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
                              color: Colors.blue,
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
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),

          // 댓글 섹션
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '댓글창',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 16),
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
    );
  }
}
