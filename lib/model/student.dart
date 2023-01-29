// To parse this JSON data, do
//
//     final student = studentFromJson(jsonString);

import 'dart:convert';

Student studentFromJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(Student data) => json.encode(data.toJson());

class Student {
  Student({
    this.id,
    required this.rollno,
    required this.name,
    required this.level,
  });

  String? id;
  final int rollno;
  final String name;
  final int level;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        rollno: json["rollno"],
        name: json["name"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rollno": rollno,
        "name": name,
        "level": level,
      };
}
