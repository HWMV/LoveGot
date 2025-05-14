import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/signup_screen.dart';
import 'features/home/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final user = FirebaseAuth.instance.currentUser;
  print('🔥 초기 로그인 유저: ${user?.uid}');

  runApp(const LoveGot());
}

class LoveGot extends StatelessWidget {
  const LoveGot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoveGot',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return const HomeScreen();
          }

          return const LoginScreen();
        },
      ),
      routes: {
        '/signup': (context) => const SignUpScreen(),
      },
    );
  }
}
