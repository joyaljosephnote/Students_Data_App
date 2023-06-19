import 'package:flutter/material.dart';
import 'package:students_app/database/functions/db_functions.dart';
import 'package:students_app/model/data_model.dart';

class StudentsRegister extends StatelessWidget {
  StudentsRegister({super.key});

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _mobileNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Register',
        ),
        // actions: [Icon(showSearch(context: context, delegate: delegate))],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    fillColor: Colors.white70),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    fillColor: Colors.white70),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _mobileNumberController,
                decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    fillColor: Colors.white70),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      onAddStudententButtonClicked();
                      _nameController.clear();
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Save'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _ageController.clear();
                    },
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Edit'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _mobileNumberController.clear();
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onAddStudententButtonClicked() async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    if (_name.isEmpty || _age.isEmpty) {
      return;
    }
    print('$_name  $_age');

    final _student = StudentModel(name: _name, age: _age);

    addStudent(_student);
  }
}
