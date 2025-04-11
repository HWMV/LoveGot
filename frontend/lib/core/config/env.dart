/*
* 환경 설정 관리 파일
* 
* 개발 환경: env.dev.dart (개발용 URL)
* 운영 환경: env.prod.dart (env.prod.template.dart를 복사하여 생성, .gitignore에 포함)
* 
* 사용 방법:
* - 개발 시: 기본값으로 개발 환경 사용
* - 배포 시: --dart-define=DEV_MODE=false 옵션으로 빌드
*/

import 'env.dev.dart';
import 'env.prod.dart';

class Env {
  static const bool isDevelopment = bool.fromEnvironment(
    'DEV_MODE',
    defaultValue: true,
  );

  static String get apiUrl {
    if (isDevelopment) {
      return EnvDev.apiUrl;
    } else {
      return EnvProd.apiUrl;
    }
  }
}
