import 'package:flutter/material.dart';
import 'package:students_app/screens/register.dart';
import 'package:students_app/screens/students_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentSelectedIndex = 0;

  final _pages = [
    const StudentsList(),
    StudentsRegister(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        currentIndex: _currentSelectedIndex,
        onTap: (newIndex) {
          setState(() {
            _currentSelectedIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.auto_stories_rounded), label: 'Register'),
          BottomNavigationBarItem(
              icon: Icon(Icons.create), label: 'Add Student'),
        ],
      ),
    );
  }
}
