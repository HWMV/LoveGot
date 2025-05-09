import 'package:flutter/material.dart';

class BalanceQuestionView extends StatelessWidget {
  final Function(int) onOptionSelected;

  const BalanceQuestionView({
    Key? key,
    required this.onOptionSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '남자 소변 앉아서 싸기 vs 서서 싸기',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          '당신의 사연과 서로의 입장을 적어주세요!\n많은 커플들의 생각을 들어보아요!',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 24),
        _buildOptionButton(
          text: '1번 : 앉아서 싸기',
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
      ],
    );
  }

  Widget _buildOptionButton({
    required String text,
    required int option,
  }) {
    return GestureDetector(
      onTap: () => onOptionSelected(option),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
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
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
