
import 'dart:convert';
import 'package:flutter/widgets.dart';

class Prorole {
  
  final int? id;
  final String description;
  final bool active;
  final int rightid;
  
  Prorole({
    
    this.id,
    required this.description,
    required this.active,
    required this.rightid,
  });

  // Convert a prorole into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
	  
      'id': id,
      'description': description,
      'active': active,
      'rightid': rightid,
    };
  }

  bool intToBool(int value) {
    return value != 0;
  }

  factory Prorole.fromMap(Map<String, dynamic> map) {
    return Prorole(
	  
      id: map['id']?.toInt() ?? 0,
      description: map['description'] ?? '',
      active: map['active'] != 0,
      rightid: map['rightid']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Prorole.fromJson(String source) => Prorole.fromMap(json.decode(source));

  // Implement toString to make it easier to see information about
  // each prorole when using the print statement.
  @override
  String toString() {
    return 'prorole(id: $id,description: $description,active: $active,rightid: $rightid)';
  }
}