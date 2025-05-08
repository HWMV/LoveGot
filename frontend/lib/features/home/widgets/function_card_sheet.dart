import 'package:flutter/material.dart';

class FunctionCardSheet extends StatelessWidget {
  final Color brownColor;

  const FunctionCardSheet({
    Key? key,
    required this.brownColor,
  }) : super(key: key);

  // 기능 리스트 정의
  final List<Map<String, dynamic>> _functionList = const [
    {'title': '긍정대화법 훈련', 'icon': Icons.chat_bubble_outline},
    {'title': '공감&상담 에이전트', 'icon': Icons.psychology_outlined},
    {'title': '커뮤니티', 'icon': Icons.people_outline},
    {'title': '밸런스 게임', 'icon': Icons.compare_arrows},
    {'title': '칭찬카드', 'icon': Icons.card_giftcard},
    {'title': '요청카드', 'icon': Icons.favorite_outline},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 드래그 핸들
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          // 전체 기능 리스트 스크롤
          SizedBox(
            height: 120, // 스크롤 가능한 높이 설정
            child: ListView.builder(
              itemCount: _functionList.length,
              itemBuilder: (context, index) {
                final item = _functionList[index];
                return _buildFunctionCard(item['title'], item['icon']);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFunctionCard(String title, IconData icon) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: brownColor),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        onTap: () {
          // TODO: 기능별 이동 처리
        },
      ),
    );
  }
}
