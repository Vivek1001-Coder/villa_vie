import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper
{
  static Future<void> setName(String name) async
  {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name',name);
  }

  static Future<String?> getName() async
  {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  static Future<void> setToken(String name) async
  {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token',name);
  }

  static Future<String?> getToken() async
  {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token')?? "";
  }

  static Future<String?> getEmail() async
  {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  static Future<void> setLoginStatus(bool status) async
  {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', status);
  }

  static Future<bool> getLoginStatus() async
  {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<void> clearAll() async
  {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> saveUserData(
      String name,
      String lastName,
      String email,
      String password,
      bool isLoggedIn,
      String loginType,
      String assignedShip,
      String countryCode,
      String phoneNumber,
      String id
      ) async
  {
    final prefs = await SharedPreferences.getInstance();
    print("Saving user data: """
        "$name, $lastName, $email, $password, $isLoggedIn, $loginType,"
        " $assignedShip, $countryCode, $phoneNumber, $id");
    await prefs.setString('name', name);
    await prefs.setString('lastName', lastName);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setBool('isLoggedIn', isLoggedIn);
    await prefs.setString('loginType', loginType);
    await prefs.setString('assignedShip', assignedShip);
    await prefs.setString('countryCode', countryCode);
    await prefs.setString('phoneNumber', phoneNumber);
    await prefs.setString('id', id);
  }

  static Future<Map<String,dynamic>> readUserData() async
  {
    final prefs = await SharedPreferences.getInstance();
    Map<String,dynamic> userData = {};

    userData["name"] = prefs.getString('name');
    userData["isLoggedIn"] = prefs.getBool('isLoggedIn');
    userData["lastName"] = prefs.getString('lastName');
    userData["email"] = prefs.getString('email');
    userData["password"] = prefs.getString('password');
    userData["loginType"] = prefs.getString('loginType');
    userData["assignedShip"] = prefs.getString('assignedShip');
    userData["countryCode"] = prefs.getString('countryCode');
    userData["phoneNumber"] = prefs.getString('phoneNumber');
    userData["id"] = prefs.getString('id');

    return userData;
  }

}
