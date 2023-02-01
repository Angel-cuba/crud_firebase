import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/crud/add_student.dart';
import 'package:crud_firebase/crud/update_student.dart';
import 'package:crud_firebase/model/student.dart';
import 'package:crud_firebase/navigation/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../crud/details_student.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<HomePage> createState() => _HomePageState();
}

final CollectionReference studentsCollection =
    FirebaseFirestore.instance.collection('students');

class _HomePageState extends State<HomePage> {
  //List of images to render
  List<String> images = [
    'https://picsum.photos/250?image=31',
    'https://picsum.photos/250?image=2',
    'https://picsum.photos/250?image=13',
    'https://picsum.photos/250?image=4',
    'https://picsum.photos/250?image=25',
    'https://picsum.photos/250?image=6',
    'https://picsum.photos/250?image=7',
    'https://picsum.photos/250?image=8',
    'https://picsum.photos/250?image=31',
    'https://picsum.photos/250?image=2',
    'https://picsum.photos/250?image=13',
    'https://picsum.photos/250?image=4',
    'https://picsum.photos/250?image=25',
    'https://picsum.photos/250?image=6',
    'https://picsum.photos/250?image=7',
    'https://picsum.photos/250?image=8',
    'https://picsum.photos/250?image=19',
    'https://picsum.photos/250?image=10',
  ];

  bool isSearching = false;
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    final fullWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {},
          child: const Icon(Icons.menu),
        ),
        backgroundColor: Colors.redAccent.shade700,
        title: isSearching
            ? Card(
                child: TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search...',
                    contentPadding: EdgeInsets.only(left: 15),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              )
            : Text("TODO ${widget.title}"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
              });
            },
            icon: isSearching
                ? const Icon(Icons.close)
                : const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              userSignedOut(context);
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: studentsCollection.get(),
        builder: (context, snapshot) {
          // ?Throw error if any
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          if (snapshot.hasData) {
            //! Firebase data
            QuerySnapshot? data = snapshot.data!;
            List<QueryDocumentSnapshot> studentsData = data.docs;
            //!Convert the list of documents to list of students
            List<Student> allStudents = studentsData
                .map((e) => Student(
                    id: e['id'],
                    name: e['name'],
                    level: e['level'],
                    rollno: e['rollno']))
                .toList();
            return getStudents(
                context, allStudents, fullHeight, fullWidth, images);
          } else {
            // ?Loading
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.redAccent.shade700,
          elevation: 6,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.redAccent.shade400)),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddStudent()));
          },
          tooltip: 'Add',
          label: const Text('New Student'),
          icon: const Icon(Icons.pages)),
    );
  }

  Widget getStudents(
      context, List<Student> students, fullHeight, fullWidth, images) {
    return students.isEmpty
        ? const Center(
            child: Text('No students found'),
          )
        : Padding(
            padding: EdgeInsets.only(bottom: fullHeight * 0.019),
            child: Column(
              children: [
                Container(
                  height: fullHeight * 0.1,
                  width: fullWidth,
                  color: Colors.redAccent.shade700,
                  child: const Center(
                    child: Text(
                      'Students',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'List of students',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: searchQuery.isEmpty
                      ? ListView.builder(
                          itemCount: students.length,
                          itemBuilder: (context, index) => getCard(
                              students, index, context, images, fullWidth))
                      : ListView.builder(
                          itemCount: students.length,
                          itemBuilder: (context, index) {
                            if (students[index]
                                .name
                                .toLowerCase()
                                .toLowerCase()
                                .startsWith(searchQuery.toLowerCase())) {
                              return getCard(
                                  students, index, context, images, fullWidth);
                            }
                            return const SizedBox();
                          },
                        ),
                ),
              ],
            ),
          );
  }

  Card getCard(students, int index, BuildContext context, images, fullWidth) {
    return Card(
      elevation: 5,
      color: students[index].level < 3
          ? Colors.deepOrangeAccent.shade100
          : students[index].level < 7
              ? Colors.green.shade400
              : Colors.blue.shade400,
      child: ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StudentDetails(
                          student: students[index],
                        )));
          },
          leading: CircleAvatar(
            backgroundImage: NetworkImage(images[index]),
          ),
          title: Text(students[index].name),
          subtitle: Text('Level: ${students[index].level}'),
          trailing: SizedBox(
            width: fullWidth * 0.3,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateStudent(
                                  student: students[index],
                                )));
                  },
                  icon: const Icon(Icons.edit),
                  color: Colors.green,
                ),
                IconButton(
                  onPressed: () {
                    studentsCollection
                        .doc(students[index].id)
                        .delete()
                        .then((_) => {
                              setState(() {
                                // ! Refresh the users data after deleting
                                students.removeAt(index);
                              }),
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      content: Text(
                                          'Student deleted successfully'))),
                            });
                  },
                  icon: const Icon(Icons.delete),
                  color: Colors.red.shade600,
                ),
              ],
            ),
          )),
    );
  }
}

void userSignedOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut().then((value) =>
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login())));
}
