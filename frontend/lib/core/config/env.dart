/*
* 환경 설정 관리 파일
* 
* 개발 환경: env.dev.dart (개발용 URL)
* 운영 환경: env.prod.dart (env.prod.template.dart를 복사하여 생성, .gitignore에 포함)
* 
* 사용 방법:
* - 개발 시: 기본값으로 개발 환경 사용
* - 배포 시: --dart-define=ENV=prod 옵션으로 빌드
*/

import 'env.dev.dart';
import 'env.prod.dart';

class Env {
  static const String environment = String.fromEnvironment(
    'ENV',
    defaultValue: 'dev',
  );

  static String get apiUrl {
    switch (environment) {
      case 'prod':
        return EnvProd.apiUrl;
      case 'dev':
      default:
        return EnvDev.apiUrl;
    }
  }

  static bool get isDevelopment => environment != 'prod';

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8080', // Android 에뮬레이터용
  );
}
