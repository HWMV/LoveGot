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
                  color: Color(0xFF8B7E74),
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
            color: const Color(0xFFF5EFE6),
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
            color: const Color(0xFFF5EFE6),
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
          backgroundColor: Color(0xFFE8DCCA),
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
                      color: const Color(0xFFE8DCCA),
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
                      '남자 소변 앉아서 싸기 vs 서서 싸기',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ExpandableStoryBox(
                    text: """당신의 사연과 서로의 입장을 적어주세요!\n남자친구와 소변에 대해 싸웠어..
                    \n화장실 2개 있는 집으로 이사해서 각자\n화장실을 쓰자고 하는데 자금이 그 정도 여유는 되지 않아..
                    \n어떻게 생각해? """,
                  ),
                  const SizedBox(height: 24),
                  if (!_showResult) ...[
                    _buildOptionButton(
                      text: '1번 : 앉아 싸기',
                      option: 1,
                    ),
                    const SizedBox(height: 12),
                    _buildOptionButton(
                      text: '2번 : 서서 싸기',
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
            border: Border.all(color: Color(0xFFF5EFE6)),
            borderRadius: BorderRadius.circular(12),
            color: Color(0xFFE8DCCA),
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
                  backgroundColor: Color(0xFFE8DCCA),
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
                        color: Color(0xFF8B7E74),
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
                  Icon(Icons.send, color: Color(0xFFF5EFE6)),
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
          color: isSelected ? Color(0xFFF5EFE6) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Color(0xFFE8DCCA) : Colors.grey[300]!,
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
            color: isSelected ? Color(0xFF8B7E74) : Color(0xFF8B7E74),
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
                    color: Color(0xFF8B7E74),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  _expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Color(0xFF8B7E74),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
