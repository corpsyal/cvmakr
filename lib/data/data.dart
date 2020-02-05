import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Data {
  static const sharedKey = 'data';

  String firstName;
  String lastName;
  String age;
  String city;
  String email;
  String phone;
  String aboutMe;
  List<Experience> experiences;
  /* = [
    Experience(
        job: "Dev",
        company: "la mob",
        from: DateTime.utc(2019, 10, 28),
        to: DateTime.now(),
        description: "une description")
  ];
*/

  Data(
      {this.firstName,
      this.lastName,
      this.age,
      this.city,
      this.email,
      this.phone,
      this.aboutMe});

  Data.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        city = json['city'],
        age = json['age'],
        email = json['email'],
        phone = json['phone'],
        aboutMe = json['aboutMe']
  /*
        experiences = (json['experiences'] ?? List<Experience>()).map((exp) {
          print(exp);
          print(Experience.fromJson(exp));
          return Experience.fromJson(exp);
        }).toList() as List<Experience>

   */
  {
    print(json['experiences'] ??
        [] as List<Experience>); // erreur dans le cast !!
  }

  String toJson() => jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'age': age,
        'city': city,
        'email': email,
        'phone': phone,
        'aboutMe': aboutMe,
        'experiences': (experiences ?? []).map((e) => e.toJson()).toList()
      });

  void save() async {
    SharedPreferences sharedInstance = await SharedPreferences.getInstance();
    print(this.toJson());
    await sharedInstance.setString(sharedKey, this.toJson());
  }

  static Future<Data> restoreData() async {
    try {
      final shared = await SharedPreferences.getInstance();
      String savedData = shared.getString(sharedKey);
      Map<String, dynamic> decodedData = jsonDecode(savedData ?? "{}");
      print(Data.fromJson(decodedData));
      return Data.fromJson(decodedData);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}

class Experience {
  String job;
  String company;
  DateTime from;
  DateTime to;
  String description;

  Experience({this.job, this.company, this.from, this.to, this.description});

  Experience.fromJson(Map<String, dynamic> exp)
      : job = exp["job"],
        company = exp["company"],
        from = DateTime.parse(exp["from"]),
        to = DateTime.parse(exp["from"]),
        description = exp["description"];

  String toJson() => jsonEncode({
        'job': job,
        'company': company,
        'from': from.toString(),
        'to': to.toString(),
        'description': description,
      });
}
