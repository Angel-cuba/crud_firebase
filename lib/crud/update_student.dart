import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/model/student.dart';
import 'package:crud_firebase/navigation/navigator.dart';
import 'package:flutter/material.dart';

class UpdateStudent extends StatefulWidget {
  final Student student;

  const UpdateStudent({super.key, required this.student});

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    _idController.text = widget.student.id!;
    _nameController.text = widget.student.name;
    _rollNoController.text = '${widget.student.rollno}';
    _levelController.text = '${widget.student.level}';
    return Scaffold(
      appBar: AppBar(
        title: Text('Update ${_nameController.text} details'),
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
            placeholder: 'Roll No ',
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
                  onPressed: () {
                    Student updatedStudent = Student(
                        id: _idController.text,
                        rollno: int.parse(_rollNoController.text),
                        name: _nameController.text,
                        level: int.parse(_levelController.text));
                    //! Update student in firebase
                    final collectionReference =
                        FirebaseFirestore.instance.collection('students');
                    collectionReference
                        .doc(widget.student.id)
                        .update(updatedStudent.toJson())
                        .then((value) {
                      //! Show snackbar if the student is updated
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Student updated')));

                      //! Navigate to home page
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NavigateToPage()));
                    });
                  },
                  child: const Text('Update',
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
    );
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
}
