import 'package:flutter/material.dart';

class BalanceOptionButton extends StatelessWidget {
  final String text;
  final int option;
  final int selectedOption;
  final Function(int) onTap;

  const BalanceOptionButton({
    Key? key,
    required this.text,
    required this.option,
    required this.selectedOption,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedOption == option;

    return GestureDetector(
      onTap: () => onTap(option),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFFDF7F0) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? Color(0xFFBFAF95) : Colors.grey[300]!,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w400,
            color: isSelected ? Color(0xFF5E5246) : Color(0xFF7A6F67),
          ),
        ),
      ),
    );
  }
}
