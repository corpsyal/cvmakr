import 'dart:convert';
import 'experience.dart';
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

  Data(
      {this.firstName,
      this.lastName,
      this.age,
      this.city,
      this.email,
      this.phone,
      this.aboutMe,
      this.experiences});

  Data.fromMap(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        city = json['city'],
        age = json['age'],
        email = json['email'],
        phone = json['phone'],
        aboutMe = json['aboutMe'],
        experiences = List<Experience>.from((json['experiences'] ?? []).map((exp) => Experience.fromMap(exp)));

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'age': age,
        'city': city,
        'email': email,
        'phone': phone,
        'aboutMe': aboutMe,
        'experiences': experiences
      };

  void save() async {
    SharedPreferences sharedInstance = await SharedPreferences.getInstance();
    await sharedInstance.setString(sharedKey, jsonEncode(this.toJson()));
  }

  static Future<Data> restoreData() async {
    try {
      final shared = await SharedPreferences.getInstance();
      String savedData = shared.getString(sharedKey);
      Map<String, dynamic> decodedData = jsonDecode(savedData ?? "{}");
      return Data.fromMap(decodedData);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}

