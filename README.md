# dart_codable

Implementing the Swift Codable Protocol using mirrors.

## Example
First of all import the package alongside the dart:convert package.

    import 'dart:convert';
    import 'package:dart_codable/dart_codable.dart';


Have your Class extend the Codable Class. Note that you have to pass down the constructor from the superclass because dart does not automatically create non-default constructors.

    class Person extends Codable{
      Person.decode(Map<String, dynamic> data) : super.decode(data);

      String name;
      int age;
      double score;
    }

Then simply use it:

    String jsonString = "{ \"name\": \"Marco\", \"age\": 24, \"score\": 99.9 }";

    Person me = Person.decode(json.decode(jsonString));

    print("Name: ${me.name}");
    print("Age: ${me.age}");
    print("Score: ${me.score}");
    print("");

    print(json.encode(me.encode()));

Which outputs 

    Name: Marco
    Age: 24
    Score: 99.9

    {"name":"Marco","age":24,"score":99.9}
