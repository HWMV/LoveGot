import 'package:flutter/material.dart';
import '../widgets/expandable_story_box.dart';
import '../widgets/balance_option_button.dart';
import '../widgets/balance_result_view.dart';

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
            '밸런스 게임',
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
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2E8D5),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Color(0xFFBFAF95), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.brown.withOpacity(0.1),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Text(
                      '남자 소변 앉아서 싸기 vs 서서 싸기',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Pretendard',
                        color: Color(0xFF5E5246),
                      ),
                      textAlign: TextAlign.center,
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
                    BalanceOptionButton(
                      text: '1번 : 앉아 싸기',
                      option: 1,
                      selectedOption: _selectedOption,
                      onTap: _onOptionSelected,
                    ),
                    const SizedBox(height: 12),
                    BalanceOptionButton(
                      text: '2번 : 서서 싸기',
                      option: 2,
                      selectedOption: _selectedOption,
                      onTap: _onOptionSelected,
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
                    BalanceResultView(
                      option1Percentage: _option1Percentage,
                      option2Percentage: _option2Percentage,
                      partnerOption: _partnerOption,
                      selectedOption: _selectedOption,
                    ),
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
                  IconButton(
                    icon: Icon(Icons.emoji_emotions_outlined,
                        color: Color(0xFF8B7E74)),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '여러분의 생각을 적어주세요!',
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                  Icon(Icons.send, color: Color(0xFF8B7E74)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
