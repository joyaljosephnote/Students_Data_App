// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

import '../../model/data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

void addStudent(StudentModel value) {
  studentListNotifier.value.add(value);
  // print(value.toString());
  // ignore: invalid_use_of_visible_for_testing_member
  studentListNotifier.notifyListeners();
}
