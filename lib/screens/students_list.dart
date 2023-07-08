import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:students_app/database/functions/db_functions.dart';
import 'package:students_app/model/data_model.dart';
import 'package:students_app/screens/student_profile_view.dart';
import 'package:image_picker/image_picker.dart';

XFile? images;
// ignore: non_constant_identifier_names
late StudentModel Student;
TextEditingController searchController = TextEditingController();
TextEditingController nameField = TextEditingController();
TextEditingController ageField = TextEditingController();
TextEditingController phoneField = TextEditingController();
TextEditingController parentNameField = TextEditingController();
bool isListEmpty = true;

final formKey = GlobalKey<FormState>();

class StudentsList extends StatefulWidget {
  const StudentsList({super.key});

  @override
  State<StudentsList> createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Align(
                child: Text(
                  "Student Record",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.staatliches(
                      textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                  )),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                    labelText: 'Search',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        searchAndUpdateStudents(searchController.text);
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: false,
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    hintText: "Type student Name",
                    fillColor: Colors.white70),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: studentListNotifier,
                  builder: (BuildContext ctx, List<StudentModel> studentsList,
                      Widget? child) {
                    isListEmpty = studentsList.isEmpty;
                    return isListEmpty
                        ? const Center(
                            child: Text('Students record is Empty'),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context1, index) {
                              final data = studentsList[index];
                              return Card(
                                color: const Color.fromARGB(255, 243, 244, 245),
                                child: ListTile(
                                  onTap: () {
                                    Student = StudentModel(
                                      name: data.name,
                                      parentName: data.parentName,
                                      age: data.age,
                                      mobileNumber: data.mobileNumber,
                                      images: data.images,
                                    );
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx1) =>
                                            const StudentProfileView(),
                                      ),
                                    );
                                  },
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        FileImage(File(data.images)),
                                    radius: 30,
                                  ),
                                  title: Text(
                                    data.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(data.age),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          editField(
                                              context1, studentsList[index]);
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (ctx) {
                                                return AlertDialog(
                                                  title: const Text('Delete'),
                                                  content: const Text(
                                                      'Are you sure want to delete'),
                                                  actions: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        deleteStudent(data);
                                                        Navigator.of(ctx).pop();
                                                      },
                                                      // ignore: sort_child_properties_last
                                                      child: const Text('Yes'),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Colors.black),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(ctx).pop();
                                                      },
                                                      // ignore: sort_child_properties_last
                                                      child: const Text('No'),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Colors.black),
                                                    )
                                                  ],
                                                );
                                              });
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            // separatorBuilder: (context, index) {
                            //   return const Divider();
                            // },
                            itemCount: studentsList.length,
                          );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void editField(ctx2, StudentModel student) {
    nameField = TextEditingController(text: student.name);
    ageField = TextEditingController(text: student.age);
    phoneField = TextEditingController(text: student.mobileNumber);
    parentNameField = TextEditingController(text: student.parentName);

    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx2,
      builder: (ctx1) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx1).viewInsets.bottom),
        child: Container(
          height: 500,
          width: double.infinity,
          color: Colors.white60,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                    child: Text(
                      "Edit Student Details",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.staatliches(
                          textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                      )),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     images = null;
                  //     uploadImage(context);
                  //   },
                  //   child: CircleAvatar(
                  //     radius: 80,
                  //     backgroundColor: Colors.white,
                  //     child: ClipRRect(
                  //       child: Container(
                  //         alignment: Alignment.center,
                  //         decoration: BoxDecoration(
                  //           shape: BoxShape.rectangle,
                  //           image: DecorationImage(
                  //             image: FileImage(File(Student.images)),
                  //             fit: BoxFit.contain,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                    controller: nameField,
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
                    controller: parentNameField,
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
                    controller: ageField,
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
                    controller: phoneField,
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
                      if (formKey.currentState!.validate()) {
                        editStudentDetails(ctx1, student);
                      }
                    },
                    label: const Text('SAVE CHANGES'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  editStudentDetails(context, student) {
    final name = nameField.text;
    final age = ageField.text;
    final phone = phoneField.text;
    final parentName = parentNameField.text;

    if (name.isEmpty || age.isEmpty || phone.isEmpty || parentName.isEmpty) {
      return;
    } else {
      Navigator.of(context).pop();
      editstudent(
        studentModel: student,
        name: nameField.text,
        age: ageField.text,
        mobilePhone: phoneField.text,
        parentName: parentNameField.text,
      );
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
}
