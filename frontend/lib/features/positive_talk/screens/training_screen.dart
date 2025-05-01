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
  int? _pressedIndex;

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
      return 'assets/images/scenario_002.png';
    } else if (selectedIndex == 1) {
      return 'assets/images/scenario_001.png';
    } else {
      return 'assets/images/scenario_001.png';
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
              // Use SizedBox to constrain height and remove vertical padding, so avatar aligns flush to top
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    // Remove mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Avatar and response box (overlapping)
                      Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: scenarioColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            // Avatar image centered vertically and horizontally
                            Center(
                              child: Image.asset(
                                _getResultAvatar(
                                    widget.scenarioId, _selectedIndex!),
                                width: MediaQuery.of(context).size.width * 0.65,
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
                            // Response box, overlapping with avatar (moved up)
                            Positioned(
                              bottom: 150,
                              left: MediaQuery.of(context).size.width * 0.05,
                              right: MediaQuery.of(context).size.width * 0.05,
                              child: Container(
                                // Overlap more with the avatar image by using higher bottom offset
                                margin: const EdgeInsets.only(bottom: 0),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.85),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  _getResponse(scenario, _selectedIndex!),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF333333),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Next Button, always visible within the viewport
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showSituationSelectionDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: scenarioColor.withOpacity(0.95),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 4,
                            shadowColor: Colors.black45,
                          ),
                          child: const Text(
                            '다음 연습하기',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
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
                      Container(
                        width: double.infinity,
                        // Remove margin, use only internal horizontal padding
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: scenarioColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text.rich(
                          TextSpan(text: scenario.prompt),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
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
                              child: GestureDetector(
                                onTapDown: (_) {
                                  setState(() {
                                    _pressedIndex = index;
                                  });
                                },
                                onTapUp: (_) {
                                  setState(() {
                                    _pressedIndex = null;
                                  });
                                },
                                onTapCancel: () {
                                  setState(() {
                                    _pressedIndex = null;
                                  });
                                },
                                onTap: () {
                                  setState(() {
                                    _selectedIndex = index;
                                    _showResult = true;
                                  });
                                },
                                child: AnimatedScale(
                                  scale: _pressedIndex == index ? 0.95 : 1.0,
                                  duration: const Duration(milliseconds: 100),
                                  curve: Curves.easeInOut,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: _selectedIndex == index
                                            ? const Color(
                                                0xFFB39397) // Darker border when selected
                                            : const Color(
                                                0xFFDDC6C9), // Subtle border when unselected
                                        width: 1.5,
                                      ),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 36,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Center(
                                          child: Text(
                                            scenario.choices[index],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFF333333),
                                            ),
                                          ),
                                        ),
                                      ),
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
