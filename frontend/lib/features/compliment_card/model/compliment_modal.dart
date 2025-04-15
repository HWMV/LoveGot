import 'package:flutter/material.dart';
import '../../../shared/widgets/primary_button.dart';

class ComplimentModal extends StatefulWidget {
  const ComplimentModal({Key? key}) : super(key: key);

  @override
  State<ComplimentModal> createState() => _ComplimentModalState();
}

class _ComplimentModalState extends State<ComplimentModal> {
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

  void _handleSubmit() {
    Navigator.of(context).pop({
      'compliment': _textController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
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
                            PrimaryButton(
                              text: '칭찬카드 보내기',
                              onPressed: _hasText ? _handleSubmit : () {},
                              isLoading: false,
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
