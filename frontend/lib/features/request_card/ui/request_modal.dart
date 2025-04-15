// request_card 모델

import 'package:flutter/material.dart';
import '../service/request_service.dart';

class RequestDialog extends StatefulWidget {
  const RequestDialog({Key? key}) : super(key: key);

  @override
  State<RequestDialog> createState() => _RequestDialogState();
}

class _RequestDialogState extends State<RequestDialog> {
  final TextEditingController _textController = TextEditingController();
  List<String>? _suggestions;
  String? _selectedSuggestion;
  bool _isLoading = false;
  String? _originalText;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _hasText = _textController.text.isNotEmpty;
    });
  }

  Future<void> _getAISuggestions() async {
    if (!_hasText) return;

    setState(() {
      _isLoading = true;
      _originalText = _textController.text;
    });

    try {
      final response =
          await RequestService.getAISuggestions(_textController.text);
      setState(() {
        _suggestions = [
          response['Answer1'],
          response['Answer2'],
          response['Answer3'],
        ];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('오류가 발생했습니다: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 메인 컨테이너
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  // 배경 이미지
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/dialog_bg.png',
                        fit: BoxFit.cover,
                        opacity: const AlwaysStoppedAnimation(0.15),
                      ),
                    ),
                  ),
                  // 메인 콘텐츠
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          '요청할 말을 입력하세요',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.pink.shade50.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.pink.shade100,
                              width: 1.5,
                            ),
                          ),
                          child: TextField(
                            controller: _textController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(16),
                              hintText: '요청사항을 입력해주세요',
                              hintStyle: TextStyle(
                                color: Colors.pink.shade200,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (_suggestions == null)
                          ElevatedButton(
                            onPressed: _hasText ? _getAISuggestions : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink.shade400,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : const Text(
                                    'AI 진단 및 개선',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          )
                        else ...[
                          if (_originalText != null) ...[
                            Text(
                              '원래 표현:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.pink.shade700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.pink.shade50.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.pink.shade100,
                                  width: 1,
                                ),
                              ),
                              child: Text(_originalText!),
                            ),
                            const SizedBox(height: 20),
                          ],
                          Text(
                            '개선된 표현을 선택해주세요',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.pink.shade700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ...List.generate(
                            _suggestions!.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: AnimatedSuggestionCard(
                                suggestion: _suggestions![index],
                                isSelected:
                                    _suggestions![index] == _selectedSuggestion,
                                onTap: () {
                                  setState(() {
                                    _selectedSuggestion = _suggestions![index];
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.pink.shade300,
                                ),
                                child: const Text('취소'),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton(
                                onPressed: _selectedSuggestion == null
                                    ? null
                                    : () {
                                        Navigator.of(context).pop({
                                          'original': _originalText,
                                          'improved': _selectedSuggestion,
                                        });
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pink.shade400,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12,
                                  ),
                                ),
                                child: const Text('선택 완료'),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedSuggestionCard extends StatefulWidget {
  final String suggestion;
  final bool isSelected;
  final VoidCallback onTap;

  const AnimatedSuggestionCard({
    Key? key,
    required this.suggestion,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  State<AnimatedSuggestionCard> createState() => _AnimatedSuggestionCardState();
}

class _AnimatedSuggestionCardState extends State<AnimatedSuggestionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _glowAnimation = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedSuggestionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _glowAnimation,
        builder: (context, child) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: widget.isSelected
                    ? Colors.pink.shade200
                    : Colors.grey.shade300,
                width: 1.5,
              ),
              boxShadow: widget.isSelected
                  ? [
                      BoxShadow(
                        color: Colors.pink.shade100.withOpacity(0.5),
                        blurRadius: _glowAnimation.value * 3,
                        spreadRadius: _glowAnimation.value,
                      ),
                    ]
                  : null,
            ),
            child: Text(
              widget.suggestion,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight:
                    widget.isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }
}
