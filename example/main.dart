import 'dart:convert';

import 'package:dart_codable/dart_codable.dart';

class Person extends Codable {
  Person.decode(Map<String, dynamic> data) : super.decode(data);

  String name;
  int age;
  Grades grades;
}

class Grades extends Codable {
  Grades.decode(Map<String, dynamic> data) : super.decode(data);

  String subject;
  double grade;
}

String jsonString =
    "{ \"name\": \"Marco\", \"age\": 24, \"grades\": { \"subject\": \"Math\", \"grade\": 1.0 } }";
String corruptedJsonString =
    "{ \"notname\": \"Marco\", \"age\": 24, \"score\": 99.9 }";

void main() {
  try{
    Person me = Person.decode(json.decode(jsonString));

    print("Name: ${me.name}");
    print("Age: ${me.age}");
    print("Grades subject: ${me.grades.subject}");
    print("Grades grade: ${me.grades.grade}");
    print("");

    print(json.encode(me.encode()));
    print("");
  } catch(e) {
    print(e);
  }

  try {
    Person.decode(json.decode(corruptedJsonString));
  } catch (e) {
    print(e);
  }
}
