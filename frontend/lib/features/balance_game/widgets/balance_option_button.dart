import 'package:flutter/material.dart';

class BalanceOptionButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const BalanceOptionButton({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.pink[50] : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.pink[200]! : Colors.transparent,
            width: 2,
          ),
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
