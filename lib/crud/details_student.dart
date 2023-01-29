import 'package:crud_firebase/model/student.dart';
import 'package:flutter/material.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({super.key, required this.student});
  final Student student;

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Center(
              child: Column(children: [
        Card(
            color: widget.student.level < 40
                ? Colors.red.shade100
                : widget.student.level < 70
                    ? Colors.green.shade100
                    : Colors.blue.shade100,
            child: Column(children: [
              const Icon(
                Icons.person_3_sharp,
                size: 100,
              ),
              Text(
                  widget.student.level < 40
                      ? 'Fail'
                      : widget.student.level < 70
                          ? 'Pass'
                          : 'Distinction',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: widget.student.level < 40
                          ? Colors.red
                          : widget.student.level < 70
                              ? Colors.green
                              : Colors.blue)),
            ])),
        const SizedBox(height: 20),
        Text('Name: ${widget.student.name}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Text('Roll No: ${widget.student.rollno}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Text('Level: ${widget.student.level}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ]))),
    );
  }
}
