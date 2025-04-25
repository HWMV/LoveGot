class Scenario {
  final String id;
  final String prompt;
  final List<String> choices;
  final int correctIndex;
  final String resultPositive;
  final List<String> resultNegative;

  Scenario({
    required this.id,
    required this.prompt,
    required this.choices,
    required this.correctIndex,
    required this.resultPositive,
    required this.resultNegative,
  });

  factory Scenario.fromMap(Map<String, dynamic> map) {
    return Scenario(
      id: map['id'] ?? '',
      prompt: map['prompt'] ?? '',
      choices: List<String>.from(map['choices'] ?? []),
      correctIndex: map['correct_index'] ?? 0,
      resultPositive: map['result_positive'] ?? '',
      resultNegative: List<String>.from(map['result_negative'] ?? []),
      //avatarUrl: '', // 아직 사용 안 하니 빈 문자열 처리
    );
  }
}
