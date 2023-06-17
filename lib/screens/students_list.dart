import 'package:flutter/material.dart';

class StudentsList extends StatelessWidget {
  const StudentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Students Register',
          textAlign: TextAlign.center,
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
          ],
        ),
      ),
    );
  }
}
