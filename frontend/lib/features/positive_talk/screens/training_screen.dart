import 'package:flutter/material.dart';
import '../models/scenario_model.dart';

class TrainingScreen extends StatefulWidget {
  final Scenario scenario;

  const TrainingScreen({Key? key, required this.scenario}) : super(key: key);

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  int? _selectedIndex;
  bool _showResult = false;

  @override
  Widget build(BuildContext context) {
    final scenario = widget.scenario;

    return Scaffold(
      appBar: AppBar(
        title: const Text('긍정 대화 훈련'),
        backgroundColor: Colors.pink.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 아바타 이미지
            // TODO: 현재는 하드코딩된 에셋 사용 중. 추후 scenario.avatarUrl을 통한 이미지 로딩으로 변경 필요
            Center(
              child: Image.asset(
                'assets/images/positive_talk_images/avatar_toothpaste_smile.png',
                height: 180,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 24),

            // 상황 설명
            Text(
              scenario.prompt,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // 질문
            const Text(
              '긍정적 대화법을 위해 어떻게 말하면 좋을까요?',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // 선택지
            ...List.generate(scenario.choices.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedIndex == index
                        ? (_isCorrect(index) ? Colors.green : Colors.red)
                        : null,
                  ),
                  onPressed: _showResult
                      ? null
                      : () {
                          setState(() {
                            _selectedIndex = index;
                            _showResult = true;
                          });
                        },
                  child: Text(scenario.choices[index]),
                ),
              );
            }),

            const SizedBox(height: 24),

            // 결과 메시지
            if (_showResult)
              Text(
                _isCorrect(_selectedIndex!)
                    ? scenario.resultPositive
                    : scenario.resultNegative[_selectedIndex!],
                style: TextStyle(
                  fontSize: 16,
                  color:
                      _isCorrect(_selectedIndex!) ? Colors.green : Colors.red,
                ),
                textAlign: TextAlign.center,
              ),

            const Spacer(),

            // 다음 버튼
            if (_showResult)
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                ),
                child: const Text('다음 연습하기'),
              ),
          ],
        ),
      ),
    );
  }

  bool _isCorrect(int index) {
    return index == widget.scenario.correctIndex;
  }
}
