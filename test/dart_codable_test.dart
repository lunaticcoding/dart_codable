import 'dart:convert';
import 'package:dart_codable/dart_codable.dart';
import 'package:test/test.dart';
import 'implementations.dart';

void main() {
  String data = "{ \"name\": \"Marco\", \"age\": 24, \"score\": 99.9 }";
  String corruptedData =
      "{ \"notname\": \"Marco\", \"age\": 24, \"score\": 99.9 }";

  group("FieldDoesNotExistException", () {
    test('FieldDoesNotExistException contains field name', () {
      expect(FieldDoesNotExistException("testField").toString(),
          contains("testField"));
    });
  });

  group("Encodable tests", () {
    test('Encodable creates valid Json', () {
      EncodableImp encodable =
          EncodableImp(name: "Marco", age: 24, score: 99.9);
      Map<String, dynamic> encodedJson = encodable.encode();

      expect(encodedJson["name"], "Marco");
      expect(encodedJson["age"], 24);
      expect(encodedJson["score"], 99.9);
    });
  });

  group("Decodable tests", () {
    test('Deodable sets all fiels correctly', () {
      DecodableImp decodable = DecodableImp.decode(json.decode(data));

      expect(decodable.name, "Marco");
      expect(decodable.age, 24);
      expect(decodable.score, 99.9);
    });

    test('Deodable throws FieldDoesNotExistException', () {
      expect(() => DecodableImp.decode(json.decode(corruptedData)),
          throwsA(const TypeMatcher<FieldDoesNotExistException>()));
    });
  });

  group("Codable tests", () {
    test('Codable encode decode returns valid Json', () {
      CodableImp codable = CodableImp.decode(json.decode(data));
      Map<String, dynamic> encodedJson = codable.encode();

      expect(encodedJson["name"], "Marco");
      expect(encodedJson["age"], 24);
      expect(encodedJson["score"], 99.9);
    });
  });
}
