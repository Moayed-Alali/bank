import 'package:flutter/material.dart';
import 'package:voice_ai_app/pages/BalanceScreen.dart';
import 'package:voice_ai_app/pages/ai_assistant.dart';
import 'package:voice_ai_app/pages/transfer_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 4;

  final List<Widget> _pages = [
    Center(child: Text("المساعد الذكي", style: TextStyle(color: Colors.white))),
    Center(child: Text("الفواتير", style: TextStyle(color: Colors.white))),
    AiAssistent(),
    TransferPage(),
    BalanceScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A), // Dark navy background
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF1B263B),
        selectedItemColor: const Color(0xFF00D4FF),
        unselectedItemColor: Colors.white70,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz_outlined),
            label: 'المساعد الذكي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'الفواتير',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'الحساب',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows_outlined),
            label: 'تحويلات',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}
