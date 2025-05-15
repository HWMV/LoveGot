import 'package:flutter/material.dart';

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
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFFFFCF7),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFD6CFC3)),
            ),
            child: Text(
              widget.text,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.normal,
                color: Color(0xFF4E4E4E),
              ),
              maxLines: _expanded ? null : 2,
              overflow: TextOverflow.fade,
            ),
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
