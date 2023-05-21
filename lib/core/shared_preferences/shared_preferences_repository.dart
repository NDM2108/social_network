import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network/helpers/response/user_model.dart';

class SharedPreferencesRepository {
  late SharedPreferences prefs;

  static final SharedPreferencesRepository _singleton = SharedPreferencesRepository._internal();

  factory SharedPreferencesRepository() {
    return _singleton;
  }

  SharedPreferencesRepository._internal();

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> setAccessToken(String value) async {
    await prefs.setString('accessToken', value);
  }

  String? getAccessToken() {
    return prefs.getString('accessToken');
  }

  Future<void> setUserInformation(UserModel value) async {
    await prefs.setString('userInformation', json.encode(value));
  }

  UserModel? getUserInformation() {
    final value = prefs.getString('userInformation');
    return UserModel.fromJson(json.decode(value ?? '{}'));
  }

  void clear() {
    prefs.remove('accessToken');
    prefs.remove('userInformation');
  }
}
