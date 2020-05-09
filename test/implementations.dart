import 'package:dart_codable/dart_codable.dart';


class EncodableImp extends Encodable{
  EncodableImp({this.name, this.age, this.score});

  String name;
  int age;
  double score;
}

class DecodableImp extends Decodable{
  DecodableImp.decode(Map<String, dynamic> data) : super.decode(data);

  String name;
  int age;
  double score;
}

class CodableImp extends Codable{
  CodableImp.decode(Map<String, dynamic> data) : super.decode(data);

  String name;
  int age;
  double score;
}