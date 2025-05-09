import 'package:flutter/material.dart';
import 'agent_thread_create_screen.dart';

class AgentThreadListScreen extends StatelessWidget {
  const AgentThreadListScreen({Key? key}) : super(key: key);

  // 앱 전체에서 사용할 베이지 계열 색상 정의
  static const Color primaryBeigeColor = Color(0xFFF5EFE6); // 밝은 베이지 (배경색)
  static const Color secondaryBeigeColor = Color(0xFFE8DCCA); // 중간 베이지 (섹션 배경)
  static const Color accentBeigeColor = Color(0xFFD4C2A8); // 진한 베이지 (액센트)
  static const Color brownColor = Color(0xFF8B7E74); // 갈색 (포인트 색상)
  static const Color lightWarmBeigeColor =
      Color(0xFFF7E6D5); // 따뜻한 연한 베이지 (고민상담)
  static const Color lightCoolBeigeColor =
      Color(0xFFECE8E1); // 차가운 연한 베이지 (갈등상담)

  @override
  Widget build(BuildContext context) {
    // 임시 데이터
    final threads = [
      {'type': '고민', 'title': '친구와의 관계 고민'},
      {'type': '갈등', 'title': '남자친구와의 말다툼'},
    ];

    return Scaffold(
      backgroundColor: primaryBeigeColor,
      appBar: AppBar(
        title: Text('고민&갈등 에이전트',
            style: TextStyle(fontStyle: FontStyle.italic, color: brownColor)),
        centerTitle: true,
        backgroundColor: secondaryBeigeColor,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: threads.length,
        itemBuilder: (context, idx) {
          final thread = threads[idx];
          final color = thread['type'] == '고민'
              ? lightWarmBeigeColor
              : lightCoolBeigeColor;
          return Card(
            color: color,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: accentBeigeColor, width: 1),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              title: Text(
                thread['title']!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: brownColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // TODO: 상세 화면으로 이동
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AgentThreadCreateScreen()),
          );
        },
        backgroundColor: brownColor,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}
