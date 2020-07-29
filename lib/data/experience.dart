import 'dart:convert';

import 'package:flutter/material.dart';

class Experience extends ChangeNotifier {
  String job;
  String company;
  DateTime from;
  DateTime to;
  String description;

  Experience({
    this.job = "",
    this.company = "",
    DateTime from,
    DateTime to,
    this.description = "",
  })  : this.from = from,
        this.to = to;

  Experience.fromMap(Map<String, dynamic> exp) {
    job = exp["job"];
    company = exp["company"];
    from = exp["from"] != 'null' ? DateTime.parse(exp["from"]) : null;
    to = exp["to"] != 'null' ? DateTime.parse(exp["to"]) : null;
    description = exp["description"];
  }

  Map<String, dynamic> toJson() => {
        'job': job,
        'company': company,
        'from': from.toString(),
        'to': to.toString(),
        'description': description,
      };

  bool isEqual(Experience exp) {
    return jsonEncode(this.toJson()) == jsonEncode(exp.toJson());
  }
}
