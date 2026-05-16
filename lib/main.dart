import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pathfinder/core/theme/app_theme.dart';
import 'package:pathfinder/features/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyA1bAZiAbIQ0iQGGpKtv-jsu9EXRVp4OY8",
        authDomain: "pathfinder-258be.firebaseapp.com",
        projectId: "pathfinder-258be",
        storageBucket: "pathfinder-258be.firebasestorage.app",
        messagingSenderId: "125148540543",
        appId: "1:125148540543:web:6a507de3299549bc56194a",
        measurementId: "G-HYMFBYDDWS",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PathFinder',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
    );
  }
}
