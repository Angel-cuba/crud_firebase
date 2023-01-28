import 'package:flutter/material.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
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
          Navigator.pop(context);
        },
        child: const Icon(Icons.save_alt_rounded),
      ),
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
