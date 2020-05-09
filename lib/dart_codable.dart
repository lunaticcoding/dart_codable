library dart_codable;

import 'dart:mirrors';

abstract class Codable extends Decodable with Encodable {
  Codable.decode(Map<String, dynamic> data) : super.decode(data);
}

abstract class Decodable {
  Decodable.decode(Map<String, dynamic> data) {
    InstanceMirror mirror = reflect(this);
    data.forEach((key, value) {
      try {
        mirror.setField(Symbol(key), value);
      } catch (e) {
        throw FieldDoesNotExistException(key);
      }
    });
  }
}

class FieldDoesNotExistException implements Exception {
  FieldDoesNotExistException(this.field);
  String field;

  @override
  String toString() {
    return "FieldDoesNotExistException: Tried setting $field on class, which does not exist";
  }
}

abstract class Encodable {
  Map<String, dynamic> encode() {
    InstanceMirror mirror = reflect(this);
    Map<String, dynamic> encoded = Map<String, dynamic>();

    for (var v in mirror.type.declarations.values) {
      var name = MirrorSystem.getName(v.simpleName);
      if (v is VariableMirror && !v.isPrivate) {
        encoded[name] = mirror.getField(Symbol(name)).reflectee;
      }
    }
    return encoded;
  }
}
