import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hotel/page/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Firebase'i başlatmadan önce bağlamı başlatın
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyC4Qee3j-SNuQYaPOBU6RJPmnKObqeu240",
          authDomain: "mg-hill-hotel-c10d4.firebaseapp.com",
          projectId: "mg-hill-hotel-c10d4",
          storageBucket: "mg-hill-hotel-c10d4.firebasestorage.app",
          messagingSenderId: "968802539905",
          appId: "1:968802539905:web:6ddc95760cac34dcadb080"),
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Home(),
    );
  }
}
