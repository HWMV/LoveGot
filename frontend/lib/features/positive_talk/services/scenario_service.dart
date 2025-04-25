import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/scenario_model.dart';

class ScenarioService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Scenario>> getScenarios() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('scenarios').get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Scenario.fromMap({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      print('Error fetching scenarios: $e');
      return [];
    }
  }

  Future<Scenario?> getScenarioById(String id) async {
    try {
      final DocumentSnapshot doc =
          await _firestore.collection('scenarios').doc(id).get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        // ID를 데이터에 포함시켜 반환
        return Scenario.fromMap({...data, 'id': doc.id});
      }
      print('No scenario found with id: $id');
      return null;
    } catch (e) {
      print('Error fetching scenario by id: $e');
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
