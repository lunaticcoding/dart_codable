import 'dart:convert';

import 'package:dart_codable/dart_codable.dart';

class Person extends Codable {
  Person.decode(Map<String, dynamic> data) : super.decode(data);

  String name;
  int age;
  double score;
}

String jsonString = "{ \"name\": \"Marco\", \"age\": 24, \"score\": 99.9 }";
String corruptedJsonString =
    "{ \"notname\": \"Marco\", \"age\": 24, \"score\": 99.9 }";

void main() {
  Person me = Person.decode(json.decode(jsonString));

  print("Name: ${me.name}");
  print("Age: ${me.age}");
  print("Score: ${me.score}");
  print("");

  print(json.encode(me.encode()));
  print("");

  try{
    Person.decode(json.decode(corruptedJsonString));
  } catch(e){
    print(e);
  }
}
