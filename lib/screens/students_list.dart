import 'dart:io';
import 'package:flutter/material.dart';
import 'package:students_app/database/functions/db_functions.dart';
import 'package:students_app/model/data_model.dart';
import 'package:students_app/screens/student_profile_view.dart';

late StudentModel Student;
TextEditingController searchController = TextEditingController();
TextEditingController nameField = TextEditingController();
TextEditingController ageField = TextEditingController();
TextEditingController phoneField = TextEditingController();
bool isListEmpty = true;

final formKey = GlobalKey<FormState>();

class StudentsList extends StatelessWidget {
  const StudentsList({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   title: const Text(
      //     'Students List',
      //   ),
      //   // actions: [Icon(showSearch(context: context, delegate: delegate))],
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
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
                    filled: true,
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
                                color: const Color.fromARGB(255, 117, 147, 122),
                                child: ListTile(
                                  onTap: () {
                                    Student = StudentModel(
                                      name: data.name,
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
                                  title: Text(data.name),
                                  subtitle: Text(data.age),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            editField(
                                                context1, studentsList[index]);
                                          },
                                          icon: Icon(Icons.edit)),
                                      IconButton(
                                        onPressed: () {
                                          deleteStudent(data);
                                          Navigator.of(ctx).pop();
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

    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx2,
      builder: (ctx1) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx1).viewInsets.bottom),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white60,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Form(
              key: formKey,
              child: ListView(
                children: [],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
