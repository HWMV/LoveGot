import 'package:flutter/material.dart';

class ComplimentDialog extends StatefulWidget {
  const ComplimentDialog({Key? key}) : super(key: key);

  @override
  State<ComplimentDialog> createState() => _ComplimentDialogState();
}

class _ComplimentDialogState extends State<ComplimentDialog> {
  final TextEditingController _textController = TextEditingController();
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
                          '칭찬할 말을 입력하세요',
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
                              hintText: '칭찬할 말을 입력해주세요',
                              hintStyle: TextStyle(
                                color: Colors.pink.shade200,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
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
                              onPressed: _hasText
                                  ? () {
                                      Navigator.of(context).pop({
                                        'compliment': _textController.text,
                                      });
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink.shade400,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                              ),
                              child: const Text('칭찬카드 보내기'),
                            ),
                          ],
                        ),
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
