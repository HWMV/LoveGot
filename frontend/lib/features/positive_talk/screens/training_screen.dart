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
      return 'images/scenario_002.png';
    } else if (selectedIndex == 1) {
      return 'images/scenario_001.png';
    } else {
      return 'images/scenario_001.png';
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
                        // Situation Description (prompt)
                        Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 320),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: scenarioColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                scenario.prompt,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF333333),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Selected Choice (above avatar)
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: scenarioColor.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: const Color(0xFFCCCCCC), width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            scenario.choices[_selectedIndex!],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Avatar Image (smaller height)
                        Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 14),
                          decoration: BoxDecoration(
                            color: scenarioColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.asset(
                            _getResultAvatar(
                                widget.scenarioId, _selectedIndex!),
                            height: MediaQuery.of(context).size.height * 0.25,
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
                        // Response
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: scenarioColor.withOpacity(0.3),
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
                        const SizedBox(height: 20),
                        // Next Button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showSituationSelectionDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: scenarioColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 18,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 0,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Situation Description (moved above avatar)
                      Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 320),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: scenarioColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              scenario.prompt,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Avatar Image
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 20),
                        decoration: BoxDecoration(
                          color: scenarioColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset(
                          'images/scenario_${widget.scenarioId}.png',
                          height: MediaQuery.of(context).size.height * 0.25,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.image_not_supported,
                              size: 80,
                              color: Colors.grey,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Question
                      const Text(
                        '긍정적 대화법을 위해 어떻게 말하면 좋을까요?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF999999),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Choices
                      ...List.generate(
                        scenario.choices.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 350),
                              child: SizedBox(
                                width: double.infinity,
                                height: 30,
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
                                        horizontal: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: const BorderSide(
                                          color: Color(0xFFEEEEEE)),
                                    ),
                                    elevation: 0,
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
