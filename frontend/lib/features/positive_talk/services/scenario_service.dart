import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/scenario_model.dart';

class ScenarioService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Scenario>> getScenarios() async {
    // 임시로 하드코딩된 데이터 사용
    return [
      Scenario(
        id: '001',
        prompt: '연인이 화장실에서 치약을 막 짜서 사용하고 나왔어!',
        choices: [
          '나는 치약이 중간부터 짜여 있으면 속상해..',
          '치약 짜는 것 좀 신경 써줄래?',
          '치약 또 중간부터 짰네?',
        ],
        correctIndex: 0,
        resultPositive: '미안해.. 끝에서부터 짜도록 노력해볼게',
        resultNegative: [
          '아 몰라몰라! 난 이게 편해!',
          '또라니.. 언제 그랬다고 그래!',
        ],
      ),
      Scenario(
        id: '002',
        prompt: '연인이 약속 시간보다 30분이나 늦게 왔어. 자주 늦는 연인이야!',
        choices: [
          '많이 기다려서 속상했어.',
          '오늘은 왜 또 늦었어?',
          '늦을 거 같으면 미리 연락 좀 해줘.',
        ],
        correctIndex: 0,
        resultPositive: '미안해.. 다음부터 더 신경 쓸게.',
        resultNegative: [
          '뭘 또야! 내가 맨날 늦었어?',
          '아! 알겠어, 뭘 그렇게 예민하게 굴어.',
        ],
      ),
    ];
  }

  Future<Scenario?> getScenarioById(String id) async {
    // 임시로 하드코딩된 데이터 사용
    switch (id) {
      case '001':
        return Scenario(
          id: '001',
          prompt: '연인이 화장실에서 치약을 막 짜서 사용하고 나왔어!',
          choices: [
            '나는 치약이 중간부터 짜여 있으면 속상해..',
            '치약 짜는 것 좀 신경 써줄래?',
            '치약 또 중간부터 짰네?',
          ],
          correctIndex: 0,
          resultPositive: '미안해.. 끝에서부터 짜도록 노력해볼게',
          resultNegative: [
            '아 몰라몰라! 난 이게 편해!',
            '또라니.. 언제 그랬다고 그래!',
          ],
        );
      case '002':
        return Scenario(
          id: '002',
          prompt: '연인이 약속 시간보다 30분이나 늦게 왔어. 자주 늦는 연인이야!',
          choices: [
            '많이 기다려서 속상했어.',
            '오늘은 왜 또 늦었어?',
            '늦을 거 같으면 미리 연락 좀 해줘.',
          ],
          correctIndex: 0,
          resultPositive: '미안해.. 다음부터 더 신경 쓸게.',
          resultNegative: [
            '뭘 또야! 내가 맨날 늦었어?',
            '아! 알겠어, 뭘 그렇게 예민하게 굴어.',
          ],
        );
      default:
        return null;
    }
  }

  // 테스트용 하드코딩 데이터 (Firebase 연결 전 테스트에 사용)
  Scenario getHardcodedScenario(String id) {
    return Scenario(
      id: "001",
      prompt: "연인이 화장실에서 치약을 막 짜서 사용하고 나왔어!",
      choices: [
        "나는 치약이 중간부터 짜여 있으면 속상해..",
        "치약 짜는 것 좀 신경 써줄래?",
        "치약 또 중간부터 짰네?"
      ],
      correctIndex: 0,
      resultPositive: "미안해.. 끝에서부터 짜도록 노력해볼게",
      resultNegative: ["아 몰라몰라! 난 이게 편해!", "또라니.. 언제 그랬다고 그래!"],
    );
  }
}
