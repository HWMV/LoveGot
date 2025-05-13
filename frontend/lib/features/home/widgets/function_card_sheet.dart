import 'package:flutter/material.dart';
import '../../positive_talk/screens/positive_talk_screen.dart';
import '../../community/screens/community_screen.dart';
import '../../balance_game/screens/balance_game_screen.dart';
import '../widgets/compliment_dialog.dart';
import '../../request_card/screens/request_modal.dart';
import '../../agent/screens/agent_thread_list_screen.dart';

class FunctionCardSheet extends StatefulWidget {
  final Color brownColor;

  const FunctionCardSheet({
    Key? key,
    required this.brownColor,
  }) : super(key: key);

  @override
  State<FunctionCardSheet> createState() => _FunctionCardSheetState();
}

class _FunctionCardSheetState extends State<FunctionCardSheet>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _heightAnimation;

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
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _heightAnimation = Tween<double>(
      begin: 100.0,
      end: 400.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(245, 245, 239, 230),
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
          GestureDetector(
            onTap: _toggleExpand,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 380,
              height: 5,
              decoration: BoxDecoration(
                color: Color(0xFFD4C2A8),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          // 전체 기능 리스트 스크롤
          AnimatedBuilder(
            animation: _heightAnimation,
            builder: (context, child) {
              return SizedBox(
                height: _heightAnimation.value,
                child: child,
              );
            },
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
      color: const Color(0xFFFFFFFF),
      child: ListTile(
        leading: Icon(icon, color: widget.brownColor),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        onTap: () {
          if (title == '긍정대화법 훈련') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PositiveTalkScreen()),
            );
          } else if (title == '공감&상담 에이전트') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AgentThreadListScreen()),
            );
          } else if (title == '커뮤니티') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CommunityScreen()),
            );
          } else if (title == '밸런스 게임') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const BalanceGameScreen()),
            );
          } else if (title == '칭찬카드') {
            showDialog(
              context: context,
              builder: (context) => const ComplimentDialog(),
            );
          } else if (title == '요청카드') {
            showDialog(
              context: context,
              builder: (context) => const RequestDialog(),
            );
          }
        },
      ),
    );
  }
}
