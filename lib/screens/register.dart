// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:students_app/database/functions/db_functions.dart';
import 'package:students_app/model/data_model.dart';
import 'package:google_fonts/google_fonts.dart';

XFile? images;

class StudentsRegister extends StatefulWidget {
  const StudentsRegister({super.key});

  @override
  State<StudentsRegister> createState() => _StudentsRegisterState();
}

class _StudentsRegisterState extends State<StudentsRegister> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _mobileNumberController = TextEditingController();

  final _parentsNameController = TextEditingController();

  // ignore: non_constant_identifier_names
  final _FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: ListView(
        children: [
          const SizedBox(
            height: 42,
          ),
          Align(
            child: Text(
              "Students Register",
              textAlign: TextAlign.center,
              style: GoogleFonts.staatliches(
                  textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 35,
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _FormKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      images = null;
                      uploadImage(context);
                    },
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image:
                                  AssetImage("assets/images/studentImage.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your  full name';
                      } else {
                        return null;
                      }
                    },
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      fillColor: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your  full name';
                      } else {
                        return null;
                      }
                    },
                    controller: _parentsNameController,
                    decoration: InputDecoration(
                      labelText: 'Parent Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      fillColor: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your age';
                      } else if (int.parse(value) > 100 ||
                          int.parse(value) < 18) {
                        return 'Please enter a valid age';
                      } else {
                        return null;
                      }
                    },
                    controller: _ageController,
                    decoration: InputDecoration(
                        labelText: 'Age',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        fillColor: Colors.white70),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                      RegExp regExp = RegExp(pattern);
                      if (value == null ||
                          value.isEmpty ||
                          value.length != 10) {
                        return 'Please enter mobile number';
                      } else if (!regExp.hasMatch(value)) {
                        return 'Please enter valid mobile number';
                      }
                      return null;
                    },
                    controller: _mobileNumberController,
                    decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        fillColor: Colors.white70),
                  ),
                  const SizedBox(height: 25),
                  FloatingActionButton.extended(
                    backgroundColor: const Color.fromARGB(255, 18, 195, 112),
                    foregroundColor: Colors.white,
                    onPressed: () {
                      if (_FormKey.currentState!.validate()) {
                        onAddStudententButtonClicked(context);
                      }
                    },
                    // icon: Icon(Icons.save),
                    label: const Text('SUBMIT REGISTRATION'),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onAddStudententButtonClicked(context) async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _name = _nameController.text.trim();
    // ignore: no_leading_underscores_for_local_identifiers
    final _age = _ageController.text.trim();
    // ignore: no_leading_underscores_for_local_identifiers
    final _mobileNumber = _mobileNumberController.text.trim();
    final _parentName = _parentsNameController.text.trim();

    if (_name.isEmpty ||
        _age.isEmpty ||
        _mobileNumber.isEmpty ||
        _parentName.isEmpty) {
      return;
    } else if (images == null) {
      imageError();
    } else {
      _FormKey.currentState!.reset;
      // ignore: avoid_print
      print('$_name  $_age');

      // ignore: no_leading_underscores_for_local_identifiers
      final _student = StudentModel(
          name: _name,
          age: _age,
          mobileNumber: _mobileNumber,
          parentName: _parentName,
          images: images!.path);

      addStudent(_student);
      images = null;
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          actions: [
            Align(
              child: Text('Registration Successful'),
            )
          ],
        ),
      );
      textFeildClear();
    }
  }

  uploadImage(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 140,
        width: double.infinity,
        child: Column(
          children: [
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                images = await pickImage(ImageSource.camera);
              },
              leading: IconButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    images = await pickImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera_enhance)),
              title: const Text('Camera'),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                images = await pickImage(ImageSource.gallery);
              },
              leading: IconButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    images = await pickImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.photo)),
              title: const Text('Gallery'),
            ),
          ],
        ),
      ),
    );
  }

  imageError() {
    const snakbar = SnackBar(
      content: Text('Upload image and continue'),
      margin: EdgeInsets.all(30),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snakbar);
  }

  Future<XFile?> pickImage(ImageSource imageSource) async {
    final image = await ImagePicker().pickImage(source: imageSource);
    return image;
  }

  void textFeildClear() {
    _nameController.clear();
    _ageController.clear();
    _mobileNumberController.clear();
    _parentsNameController.clear();
  }
}
