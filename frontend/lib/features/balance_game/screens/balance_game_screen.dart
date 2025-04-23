import 'package:flutter/material.dart';

class BalanceGameScreen extends StatefulWidget {
  const BalanceGameScreen({Key? key}) : super(key: key);

  @override
  State<BalanceGameScreen> createState() => _BalanceGameScreenState();
}

class _BalanceGameScreenState extends State<BalanceGameScreen> {
  bool _showResult = false;
  int _selectedOption = 0;
  int _partnerOption = 1;
  double _option1Percentage = 76.2;
  double _option2Percentage = 23.8;

  void _onOptionSelected(int option) {
    setState(() {
      _selectedOption = option;
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
                  color: Color(0xFFFFE0EB),
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
                  color: Color(0xFFF3F3F3),
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
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFE0EB),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '연인의 선택 답변 : ${_partnerOption}번',
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFE0EB),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '당신의 선택 답변 : ${_selectedOption}번',
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.pink[100]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Text(
                '밸런스의 생각을 적어주세요!',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              Icon(Icons.send, color: Colors.pink[100]),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '커뮤니티',
          style: TextStyle(
            fontSize: 26,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '9시 출근의 정의 어떻게 생각하시나요?',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '여러분은 어떤 의견이신지 궁금해서 질문 남겨보아요~~!\n직장인분들이라면 공감하실 거라 생각합니다!',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.normal,
                ),
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
                const Spacer(),
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
                Center(
                  child: ElevatedButton(
                    onPressed: _selectedOption != 0
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
                    child: const Text(
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
              ] else ...[
                _buildResultView(),
              ],
              const SizedBox(height: 16),
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
