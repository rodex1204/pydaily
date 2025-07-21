import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pydaily/screens/inicio.dart';
import 'package:pydaily/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const PyDailyApp());
}

class PyDailyApp extends StatelessWidget {
  const PyDailyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PyDaily',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF5C6BC0),
          secondary: const Color(0xFF81C784),
          surface: Colors.white,
          background: const Color(0xFFF5F7FA),
          error: const Color(0xFFE57373),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF5C6BC0),
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: Inicio(user: User(xp: 0)),
    );
  }
}