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
      id: map['id'] as String,
      prompt: map['prompt'] as String,
      choices: List<String>.from(map['choices'] as List),
      correctIndex: map['correct_index'] as int,
      resultPositive: map['result_positive'] as String,
      resultNegative: List<String>.from(map['result_negative'] as List),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'prompt': prompt,
      'choices': choices,
      'correct_index': correctIndex,
      'result_positive': resultPositive,
      'result_negative': resultNegative,
    };
  }
}
