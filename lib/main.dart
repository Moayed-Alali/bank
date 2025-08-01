import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://mskamsppffciezfgwpos.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1za2Ftc3BwZmZjaWV6Zmd3cG9zIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTM5ODQ5MzUsImV4cCI6MjA2OTU2MDkzNX0.yWraGc-TY8ti088IqqG35woWVu8lw-IlbWyJu8ncUfk',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF3B82F6),
        scaffoldBackgroundColor: Color(0xFFF0F4F8),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black87),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF3B82F6),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.6),
          type: BottomNavigationBarType.fixed,
        ),
        cardColor: Color(0xFF93C5FD),
      ),
      home: HomePage(),
    );
  }
}
