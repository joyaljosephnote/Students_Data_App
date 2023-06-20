import 'package:flutter/material.dart';
import 'package:students_app/database/functions/db_functions.dart';
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
    const StudentsRegister(),
    const StudentsList(),
  ];
  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      body: _pages[_currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white60,
        unselectedItemColor: Colors.black,
        selectedItemColor: const Color.fromARGB(255, 3, 127, 214),
        currentIndex: _currentSelectedIndex,
        onTap: (newIndex) {
          setState(() {
            _currentSelectedIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.create), label: 'Add Student'),
          BottomNavigationBarItem(
              icon: Icon(Icons.auto_stories_rounded), label: 'Students List'),
        ],
      ),
    );
  }
}
