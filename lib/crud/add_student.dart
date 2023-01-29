import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/model/student.dart';
import 'package:flutter/material.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _levelController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  Widget _buildTextField(
      {required String label,
      required String placeholder,
      TextInputType textInputType = TextInputType.name,
      required TextEditingController controller,
      FocusNode? focusNode}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        focusNode: focusNode,
        keyboardType: textInputType,
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          labelText: label,
          hintText: placeholder,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          _buildTextField(
            focusNode: _focusNode,
            label: 'Name',
            placeholder: 'Enter name',
            controller: _nameController,
          ),
          _buildTextField(
            label: 'Roll No',
            placeholder: 'Roll No',
            textInputType: TextInputType.number,
            controller: _rollNoController,
          ),
          _buildTextField(
            label: 'Level',
            placeholder: 'Enter level',
            textInputType: TextInputType.number,
            controller: _levelController,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent.shade100,
                      foregroundColor: Colors.greenAccent.shade700),
                  onPressed: () {},
                  child: const Text('Edit',
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.bold))),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent.shade100,
                  foregroundColor: Colors.redAccent.shade700,
                ),
                onPressed: () {
                  _nameController.clear();
                  _rollNoController.clear();
                  _levelController.clear();
                  _focusNode.requestFocus();
                },
                child: const Text('Clear all flieds',
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold)),
              ),
            ],
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        backgroundColor: Colors.blueAccent.shade400,
        onPressed: () {
          if (_nameController.text.isEmpty ||
              _rollNoController.text.isEmpty ||
              _levelController.text.isEmpty) {
            errorMessage(context);
            return;
          } else {
            Student student = Student(
                name: _nameController.text,
                rollno: int.parse(_rollNoController.text),
                level: int.parse(_levelController.text));
            addStudentToFirebase(student, context);
          }
        },
        child: const Icon(Icons.save_alt_rounded),
      ),
    );
  }
}

void errorMessage(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: const EdgeInsets.only(left: 20, right: 15),
      duration: const Duration(seconds: 2),
      animation: CurvedAnimation(
          parent: const AlwaysStoppedAnimation(1), curve: Curves.elasticInOut),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 3, left: 13.0, right: 13.0),
      shape: ShapeBorder.lerp(
          const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          5),
      content: const Text('Please fill all fields',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26)),
      backgroundColor: Colors.red,
      showCloseIcon: true,
      closeIconColor: Colors.white70,
    ),
  );
}

void addStudentToFirebase(Student student, BuildContext context) {
  //! Add student to firebase
  final studentRef = FirebaseFirestore.instance.collection('students');
  //Initialize student id
  student.id = studentRef.doc().id;
  //Student object to jso
  final studentData = student.toJson();
  //?Add student to firebase
  studentRef.doc(student.id).set(studentData).then((value) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Student added successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }).catchError((error) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Failed to add student'),
        backgroundColor: Colors.red,
      ),
    );
  });
}
