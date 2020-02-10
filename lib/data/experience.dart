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
  })  : this.from = from ?? DateTime.now(),
        this.to = to ?? DateTime.now();

  Experience.fromMap(Map<String, dynamic> exp)
      : job = exp["job"],
        company = exp["company"],
        from = DateTime.parse(exp["from"]),
        to = DateTime.parse(exp["from"]),
        description = exp["description"];

  Map<String, dynamic> toJson() => {
        'job': job,
        'company': company,
        'from': from.toString(),
        'to': to.toString(),
        'description': description,
      };
/*
  void setFrom(DateTime from) {
    this.from = from;
    notifyListeners();
  }

  void setTo(DateTime to) {
    this.to = to;
    notifyListeners();
  }
  */
}
