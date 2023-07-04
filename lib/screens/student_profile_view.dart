import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:students_app/screens/home_screen.dart';

import 'package:students_app/screens/students_list.dart';

class StudentProfileView extends StatelessWidget {
  const StudentProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(
                height: 38,
              ),
              Align(
                child: Text(
                  "Student Profile",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.staatliches(
                      textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                      border: Border.all(
                          style: BorderStyle.solid,
                          width: 10,
                          color: Colors.white54),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: FileImage(File(Student.images)),
                          fit: BoxFit.cover)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 10, 10, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Name          :  ${Student.name}",
                    style: GoogleFonts.redHatDisplay(
                        textStyle: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1)),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 10, 10, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Parent        :  ${Student.parentName}",
                    style: GoogleFonts.redHatDisplay(
                        textStyle: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1)),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 7, 10, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Age              :  ${Student.age}",
                    style: GoogleFonts.redHatDisplay(
                        textStyle: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1)),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 7, 10, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Mobile no  :  ${Student.mobileNumber}",
                    style: GoogleFonts.redHatDisplay(
                        textStyle: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1)),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              FloatingActionButton.extended(
                backgroundColor: const Color.fromARGB(255, 18, 139, 195),
                foregroundColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop(
                    MaterialPageRoute(
                      builder: (ctx1) => const StudentsList(),
                    ),
                  );
                },
                label: const Text('  RETURN TO STUDENTS LIST  '),
              ),
              const SizedBox(height: 20),
              FloatingActionButton.extended(
                backgroundColor: const Color.fromARGB(255, 18, 139, 195),
                foregroundColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx1) => const HomeScreen(),
                    ),
                  );
                },
                label: const Text('NEW STUDENT REGISTRATION'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
