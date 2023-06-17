import 'package:flutter/material.dart';

class StudentsRegister extends StatelessWidget {
  StudentsRegister({super.key});

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Register',
          textAlign: TextAlign.center,
        ),
        // actions: [Icon(showSearch(context: context, delegate: delegate))],
      ),
      body: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Name',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _ageController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Age',
            ),
          )
        ],
      ),
    );
  }
}
