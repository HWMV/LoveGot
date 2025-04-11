// 이 파일을 env.prod.dart로 복사하여 사용하세요.
// env.prod.dart는 .gitignore에 포함되어 있어 git에 올라가지 않습니다.
class EnvProd {
  // 실제 배포 시 여기에 실제 URL을 입력하세요
  static const String apiUrl = 'https://your-production-api-url.com';
  static const bool isDevelopment = false;
}
