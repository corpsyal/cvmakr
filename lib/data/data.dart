import 'dart:async';
import 'dart:convert';

import 'package:cvmakr/data/degree.dart';
import 'package:cvmakr/data/language.dart';
import 'package:cvmakr/data/skill.dart';
import 'package:cvmakr/i18n/i18n.dart';
import 'package:device_id/device_id.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'experience.dart';

class Data extends ChangeNotifier {
  static const sharedKey = 'data';
  static String locale = 'fr';

  String avatar;
  String firstName;
  String lastName;
  String age;
  String city;
  String email;
  String phone;
  String aboutMe;
  List<Experience> experiences;
  List<Degree> degrees;
  List<Skill> skills;
  List<Language> languages;
  String model;
  RemoteConfig remoteConfig;
  static FirebaseStorage storage =
      FirebaseStorage(storageBucket: 'gs://cvmakr-19bc1.appspot.com');
  String savedData;

  Data({
    this.avatar,
    this.firstName,
    this.lastName,
    this.age,
    this.city,
    this.email,
    this.phone,
    this.aboutMe,
    this.experiences,
    this.degrees,
    this.skills,
    this.languages,
    this.model = '01',
  });

  static String translate(String key) => all[locale][key];

  void switchLanguage(String newLanguage) {
    locale = newLanguage;
    save();
    notifyListeners();
  }

  void initializeFromString(String data, {config}) {
    Map<String, dynamic> json = jsonDecode(data ?? "{}");
    avatar = json['avatar'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    city = json['city'];
    age = json['age'];
    email = json['email'];
    phone = json['phone'];
    aboutMe = json['aboutMe'];
    experiences = List<Experience>.from(
        (json['experiences'] ?? []).map((exp) => Experience.fromMap(exp)));
    degrees = List<Degree>.from(
        (json['degrees'] ?? []).map((degree) => Degree.fromMap(degree)));
    skills = List<Skill>.from(
        (json['skills'] ?? []).map((skill) => Skill.fromMap(skill)));
    languages = List<Language>.from((json['languages'] ?? [])
        .map((language) => Language.fromMap(language)));
    model = json['model'] ?? "01";
    if (config != null) remoteConfig = config;
    savedData = data;
  }

  Data.fromMap(String data, config) {
    initializeFromString(data, config: config);
  }

  Map<String, dynamic> toJson() => {
        'avatar': avatar,
        'firstName': firstName,
        'lastName': lastName,
        'age': age,
        'city': city,
        'email': email,
        'phone': phone,
        'aboutMe': aboutMe,
        'experiences': experiences,
        'degrees': degrees,
        'skills': skills,
        'languages': languages,
        'model': model,
        'locale': locale
      };

  void addExperience(Experience experience) {
    experiences.add(experience);
    notifyListeners();
  }

  void removeExperience(Experience experience) {
    experiences.remove(experience);
    notifyListeners();
    save();
  }

  void moveExperience(int oldIndex, int newIndex) {
    Experience savedExperience = experiences[oldIndex];
    experiences.removeAt(oldIndex);
    experiences.insert(newIndex, savedExperience);
    notifyListeners();
    save();
  }

  void addDegree(Degree degree) {
    degrees.add(degree);
    notifyListeners();
  }

  void removeDegree(Degree degree) {
    degrees.remove(degree);
    notifyListeners();
    save();
  }

  void moveDegree(int oldIndex, int newIndex) {
    Degree savedDegree = degrees[oldIndex];
    degrees.removeAt(oldIndex);
    degrees.insert(newIndex, savedDegree);
    notifyListeners();
    save();
  }

  void addSkill(Skill skill) {
    skills.add(skill);
    notifyListeners();
  }

  void removeSkill(Skill skill) {
    skills.remove(skill);
    notifyListeners();
    save();
  }

  void moveSkill(int oldIndex, int newIndex) {
    Skill savedSkill = skills[oldIndex];
    skills.removeAt(oldIndex);
    skills.insert(newIndex, savedSkill);
    notifyListeners();
    save();
  }

  void addLanguage(Language language) {
    languages.add(language);
    notifyListeners();
  }

  void removeLanguage(Language language) {
    languages.remove(language);
    notifyListeners();
    save();
  }

  void moveLanguage(int oldIndex, int newIndex) {
    Language savedLanguage = languages[oldIndex];
    languages.removeAt(oldIndex);
    languages.insert(newIndex, savedLanguage);
    notifyListeners();
    save();
  }

  void selectModel(String id) {
    model = id;
    notifyListeners();
    save();
  }

  Future<void> save() async {
    SharedPreferences sharedInstance = await SharedPreferences.getInstance();
    String newData = jsonEncode(this.toJson());
    await sharedInstance.setString(sharedKey, newData);
    savedData = newData;
    notifyListeners();
  }

  bool hasUnsavedChange() => jsonEncode(this.toJson()) != savedData;

  void resetUnsavedChange() {
    initializeFromString(savedData);
    notifyListeners();
  }

  static Future<Data> restoreData() async {
    try {
      String device_id = await DeviceId.getID;
      print("DEVICE ID: $device_id");
      final shared = await SharedPreferences.getInstance();
      String savedData = shared.getString(sharedKey);
      print(savedData);
      //Map<String, dynamic> decodedData = jsonDecode(savedData ?? "{}");
      RemoteConfig config = await Data.setupRemoteConfig();
      return Data.fromMap(savedData, config);
    } catch (e) {
      print('erreur de restauration des datas $e');
      return Data.fromMap("{}", null);
    }
  }

  static Future<void> clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  static Future<RemoteConfig> setupRemoteConfig() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    //remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
    await remoteConfig.fetch(expiration: const Duration(seconds: 0));
    await remoteConfig.activateFetched();
    return remoteConfig;
  }
}
