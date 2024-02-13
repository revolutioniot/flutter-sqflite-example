////////////////////////////////////////////////////////////////////////////////
// protask.dart

import 'dart:convert';
import 'package:flutter/widgets.dart';

class Protask {
  
  final int? id;
  final int processdefinitionid;
  final int userid;
  final String issuedate;
  final String completedate;
  final int isueuserid;
  final String description;
  final int usergroupid;
  final bool repeat;
  
  Protask({
    
    this.id,
    required this.processdefinitionid,
    required this.userid,
    required this.issuedate,
    required this.completedate,
    required this.isueuserid,
    required this.description,
    required this.usergroupid,
    required this.repeat,
  });

  // Convert a protask into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
	  
      'id': id,
      'processdefinitionid': processdefinitionid,
      'userid': userid,
      'issuedate': issuedate,
      'completedate': completedate,
      'isueuserid': isueuserid,
      'description': description,
      'usergroupid': usergroupid,
      'repeat': repeat,
    };
  }

  factory Protask.fromMap(Map<String, dynamic> map) {
    return Protask(
	  
      id: map['id']?.toInt() ?? 0,
      processdefinitionid: map['processdefinitionid']?.toInt() ?? 0,
      userid: map['userid']?.toInt() ?? 0,
      issuedate: map['issuedate'] ?? '',
      completedate: map['completedate'] ?? '',
      isueuserid: map['isueuserid']?.toInt() ?? 0,
      description: map['description'] ?? '',
      usergroupid: map['usergroupid']?.toInt() ?? 0,
      repeat: map['repeat'].toString() == 'true');
  }

  String toJson() => json.encode(toMap());

  factory Protask.fromJson(String source) => Protask.fromMap(json.decode(source));

  // Implement toString to make it easier to see information about
  // each protask when using the print statement.
  @override
  String toString() {
    return 'Protask(id: $id,processdefinitionid: $processdefinitionid,userid: $userid,issuedate: $issuedate,completedate: $completedate,isueuserid: $isueuserid,description: $description,usergroupid: $usergroupid,repeat: $repeat)';
  }
}