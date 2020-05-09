library dart_codable;

import 'dart:mirrors';

/// Class implementing both the Decodable and the Encodable Protocol.
abstract class Codable extends Decodable with Encodable {
  /// Making the named constructor from Decodable available to children.
  Codable.decode(Map<String, dynamic> data) : super.decode(data);
}

/// Class implementing the Decodable Protocol.
abstract class Decodable {
  /// Initializes the child class with the data specified in the data Map.
  ///
  /// Iterate over the data map and initialize the fields of a class extending
  /// the Decodable Interface with the value provided.
  ///
  /// @param data Map of field name to initial value.
  /// @throws FieldDoesNotExistException If the field specified by a map key does not exist.
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

/// A custom Exception to be thrown if you try to initialize a field that does not exist.
class FieldDoesNotExistException implements Exception {
  /// Set the non-existent field.
  FieldDoesNotExistException(this.field);
  /// Field name of the non-existent field.
  final String field;

  /// String representation of the exception.
  @override
  String toString() {
    return "FieldDoesNotExistException: Tried setting $field on class, which does not exist";
  }
}

/// Class implementing the Encodable Protocol.
abstract class Encodable {
  /// Encode the class into a Map of field name to value.
  ///
  /// Iterate over the all fields in the class and create a map with the
  /// field name as a key and the fields value as a value.
  ///
  /// @returns Map of field name to initial value.
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
