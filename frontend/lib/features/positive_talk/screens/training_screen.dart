import 'package:flutter/material.dart';
import '../models/scenario_model.dart';
import '../services/scenario_service.dart';
import 'situation_selection_screen.dart';

class TrainingScreen extends StatefulWidget {
  final String scenarioId;

  const TrainingScreen({
    Key? key,
    required this.scenarioId,
  }) : super(key: key);

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  late Future<Scenario?> _scenarioFuture;
  final ScenarioService _scenarioService = ScenarioService();
  int? _selectedIndex;
  bool _showResult = false;

  @override
  void initState() {
    super.initState();
    _scenarioFuture = _scenarioService.getScenarioById(widget.scenarioId);
  }

  Color _getScenarioColor(String id) {
    switch (id) {
      case '001':
        return const Color(0xFFFFD1DC);
      case '002':
        return const Color(0xFFB5EAD7);
      case '003':
        return const Color(0xFFC7CEEA);
      default:
        return const Color(0xFFFFF5F7);
    }
  }

  String _getResultAvatar(String scenarioId, int selectedIndex) {
    if (selectedIndex == 0) {
      return 'assets/images/avatar_tooth_smile.png';
    } else if (selectedIndex == 1) {
      return 'assets/images/avatar_tooth_angry.png';
    } else {
      return 'assets/images/avatar_tooth_angry.png';
    }
  }

  String _getResponse(Scenario scenario, int selectedIndex) {
    if (selectedIndex == scenario.correctIndex) {
      return scenario.resultPositive;
    } else {
      // For incorrect choices, use the first negative response for index 1 and second for index 2
      return scenario.resultNegative[selectedIndex - 1];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF333333)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '긍정 대화법 연습',
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<Scenario?>(
          future: _scenarioFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('에러 발생: ${snapshot.error}'));
            }
            if (snapshot.data == null) {
              return const Center(child: Text('시나리오를 찾을 수 없습니다.'));
            }

            final scenario = snapshot.data!;
            final scenarioColor = _getScenarioColor(widget.scenarioId);

            if (_showResult) {
              return Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Result Avatar
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: scenarioColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.asset(
                            _getResultAvatar(
                                widget.scenarioId, _selectedIndex!),
                            height: 180,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.image_not_supported,
                                size: 80,
                                color: Colors.grey,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Selected Choice
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: scenarioColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            scenario.choices[_selectedIndex!],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Response
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFFEEEEEE)),
                          ),
                          child: Text(
                            _getResponse(scenario, _selectedIndex!),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Next Button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SituationSelectionScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: scenarioColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            '다음 연습하기',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Avatar Image
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: scenarioColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset(
                          'assets/images/avatar_tooth_smile.png',
                          width: double.infinity,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.image_not_supported,
                              size: 80,
                              color: Colors.grey,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Situation Description
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: scenarioColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          scenario.prompt,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Question
                      const Text(
                        '긍정적 대화법을 위해 어떻게 말하면 좋을까요?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF666666),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Choices
                      ...List.generate(
                        scenario.choices.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedIndex = index;
                                _showResult = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side:
                                    const BorderSide(color: Color(0xFFEEEEEE)),
                              ),
                            ),
                            child: Text(
                              scenario.choices[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF333333),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
