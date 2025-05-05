import 'package:flutter/material.dart';

class BalanceGameScreen extends StatefulWidget {
  const BalanceGameScreen({Key? key}) : super(key: key);

  @override
  State<BalanceGameScreen> createState() => _BalanceGameScreenState();
}

class _BalanceGameScreenState extends State<BalanceGameScreen> {
  bool _showResult = false;
  int _selectedOption = 0;
  int _partnerOption = 1; // 파트너의 선택 옵션
  double _option1Percentage = 76.2; // 1번 옵션의 백분율
  double _option2Percentage = 23.8; // 2번 옵션의 백분율

  void _onOptionSelected(int option) {
    if (!_showResult) {
      // 결과 화면에서는 선택 불가능하도록
      setState(() {
        _selectedOption = option;
      });
    }
  }

  void _resetState() {
    setState(() {
      _showResult = false;
      _selectedOption = 0;
    });
  }

  Widget _buildResultView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: (_option1Percentage * 10).round(),
              child: Container(
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFD6D6D6),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '1번 ${_option1Percentage.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: (_option2Percentage * 10).round(),
              child: Container(
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFB0B0B0),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '2번 ${_option2Percentage.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFE0F2FF),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            '연인의 선택 답변 : ${_partnerOption}번',
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFFFE0EB),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            '당신의 선택 답변 : ${_selectedOption}번',
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_showResult) {
          _resetState();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (_showResult) {
                _resetState();
              } else {
                Navigator.pop(context);
              }
            },
          ),
          title: const Text(
            '커뮤니티',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1E6),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Text(
                      '9시 출근의 정의 어떻게 생각하시나요?',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ExpandableStoryBox(
                    text:
                        '요즘 이야기를 나눠보면 보다 의견이 나뉘는 경우가 많더라구요.. \n여러분은 어떤 의견이신지 궁금해서 질문 남겨보아요~~!\n직장인분들이라면 공감하실 거라 생각합니다!',
                  ),
                  const SizedBox(height: 24),
                  if (!_showResult) ...[
                    _buildOptionButton(
                      text: '1번 : 9시에 업무 시작이다',
                      option: 1,
                    ),
                    const SizedBox(height: 12),
                    _buildOptionButton(
                      text: '2번 : 9시까지 출근해도 된다!',
                      option: 2,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      '700명이 참여했어요',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Epilogue',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.chat_bubble_outline),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.share),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ] else ...[
                    _buildResultView(),
                  ],
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.pink[100]!),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: _selectedOption != 0 && !_showResult
                    ? () {
                        setState(() {
                          _showResult = true;
                        });
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[100],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      '선택 완료',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '여러분의 생각을 적어주세요!',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.send, color: Colors.pink[100]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required String text,
    required int option,
  }) {
    final bool isSelected = _selectedOption == option;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOption = option;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.pink[50] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.pink[200]! : Colors.grey[300]!,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w300,
            color: isSelected ? Colors.pink[900] : Colors.black87,
          ),
        ),
      ),
    );
  }
}

class ExpandableStoryBox extends StatefulWidget {
  final String text;

  const ExpandableStoryBox({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableStoryBox> createState() => _ExpandableStoryBoxState();
}

class _ExpandableStoryBoxState extends State<ExpandableStoryBox>
    with TickerProviderStateMixin {
  bool _expanded = false;

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.normal,
            ),
            maxLines: _expanded ? null : 2,
            overflow: TextOverflow.fade,
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: _toggleExpanded,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _expanded ? '접기' : '더보기',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    color: Colors.pink[300],
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  _expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.pink[300],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
