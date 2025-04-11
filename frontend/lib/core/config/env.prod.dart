/*
* 운영 환경 설정 파일 (.gitignore에 포함되어 git에 올라가지 않음)
* 
* 주의사항:
* - 이 파일은 로컬에서만 관리되며 git에 올라가지 않습니다.
* - 실제 운영 URL 및 민감한 정보를 포함합니다.
* - env.prod.template.dart를 참고하여 생성됩니다.
*/

class EnvProd {
  static const String apiUrl =
      'https://lovegot-844249836889.us-central1.run.app';
  static const bool isDevelopment = false;
}
