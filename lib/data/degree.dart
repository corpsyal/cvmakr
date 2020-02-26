import 'package:flutter/material.dart';

class Degree extends ChangeNotifier {
  String degree;
  String school;
  DateTime from;
  DateTime to;
  String description;

  Degree({
    this.degree = "",
    this.school = "",
    DateTime from,
    DateTime to,
    this.description = "",
  })  : this.from = from,
        this.to = to;

  Degree.fromMap(Map<String, dynamic> exp)
      : degree = exp["degree"],
        school = exp["school"],
        from = DateTime.parse(exp["from"]),
        to = DateTime.parse(exp["from"]),
        description = exp["description"];

  Map<String, dynamic> toJson() => {
        'degree': degree,
        'school': school,
        'from': from.toString(),
        'to': to.toString(),
        'description': description,
      };
}
