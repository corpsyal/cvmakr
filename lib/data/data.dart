import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Data {
  static const sharedKey = 'data';

  String firstName;
  String lastName;
  String age;
  String city;
  String email;
  String phone;
  String aboutMe;

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
        aboutMe = json['aboutMe'];

  String toJson() => jsonEncode({
    'firstName': firstName,
    'lastName': lastName,
    'age': age,
    'city': city,
    'email': email,
    'phone': phone,
    'aboutMe': aboutMe
  });

  void save() async {
    SharedPreferences sharedInstance = await SharedPreferences.getInstance();
    print(this.toJson());
    await sharedInstance.setString(sharedKey, this.toJson());
  }

  static Future<Data> restoreData() async {
    final shared = await SharedPreferences.getInstance();
    String savedData = shared.getString(sharedKey);
    return savedData != null ? Data.fromJson(jsonDecode(savedData)) : Data();
  }

}
