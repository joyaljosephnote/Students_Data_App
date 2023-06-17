import 'package:flutter/material.dart';
import 'package:students_app/database/functions/db_functions.dart';
import 'package:students_app/model/data_model.dart';

class StudentsList extends StatelessWidget {
  const StudentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Students List',
        ),
        // actions: [Icon(showSearch(context: context, delegate: delegate))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              // onChanged: (value) {
              //   setState(()){

              //   }
              // },
              decoration: InputDecoration(
                  labelText: 'Search',
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  hintText: "Type student Name",
                  fillColor: Colors.white70),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: studentListNotifier,
                builder: (BuildContext ctx, List<StudentModel> studentsList,
                    Widget? child) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final data = studentsList[index];
                      return ListTile(
                        title: Text(data.name),
                        subtitle: Text(data.age),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: studentsList.length,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
