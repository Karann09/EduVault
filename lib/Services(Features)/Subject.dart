import 'package:flutter/material.dart';

class Subject extends StatefulWidget {
  const Subject({super.key});

  @override
  State<Subject> createState() => _SubjectState();
}

class _SubjectState extends State<Subject> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(title: Text("Subjects")),
        backgroundColor: Colors.white,
        body:
        SingleChildScrollView(
        child: Container(
          color: Colors.blue,
          child: Column(
            children: [
              Center(
                child: Text("Subject Page"),
              )
            ],
          ),
        ),
            ),
      );
  }
}
