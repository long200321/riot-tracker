import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  static const _keyPuuid = "puuid";

  static Future<void> savePuuid(String puuid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPuuid, puuid);
  }

  static Future<String?> getPuuid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPuuid);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyPuuid);
  }
}