import 'package:flutter/material.dart';
import '../../../shared/widgets/bottom_nav_bar.dart';
import '../../home/screens/home_screen.dart';
import 'write_post_screen.dart';

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
    final List<Map<String, String>> posts = [
      {'title': '[연애 고민] 애인이 톡 답장을 너무 늦게 해요', 'author': '익명', 'views': '302'},
      {'title': '[데이트 장소] 첫 데이트 어디가 좋을까요?', 'author': '러브러브', 'views': '187'},
      {'title': '[이별 고민] 잡아야 할까요 보내줘야 할까요', 'author': '익명', 'views': '456'},
    ];

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
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Container(
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
                    Text(
                      post['title']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.bold,
                        color: brownColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${post['author']} · 조회수 ${post['views']}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: brownColor,
                      ),
                    ),
                  ],
                ),
              );
            },
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WritePostScreen()),
          );
        },
        child: Icon(Icons.add, color: brownColor),
      ),
    );
  }
}
