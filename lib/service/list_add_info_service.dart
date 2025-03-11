// utils/shared_preferences_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const _keyTeam = 'selectedTeam';
  static const _keyFlightNumber = 'selectedFlightNumber';
  static const _keyTailNumber = 'selectedTailNumber';
  static const _keyParkingNumber = 'selectedParkingNumber';
  static const _keyPersonName = 'selectedPersonName';
  static const _keyGangBoss = 'selectedGangBoss';

  // Verileri Kaydet...
  static Future<void> saveData(Map<String, String?> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyTeam, data['team'] ?? '');
    await prefs.setString(_keyFlightNumber, data['flightNumber'] ?? '');
    await prefs.setString(_keyTailNumber, data['tailNumber'] ?? '');
    await prefs.setString(_keyParkingNumber, data['parkingNumber'] ?? '');
    await prefs.setString(_keyPersonName, data['personName'] ?? '');
    await prefs.setString(_keyGangBoss, data['gangBoss'] ?? '');
  }

  // Verileri Yükle.....
  static Future<Map<String, String?>> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'team': prefs.getString(_keyTeam),
      'flightNumber': prefs.getString(_keyFlightNumber),
      'tailNumber': prefs.getString(_keyTailNumber),
      'parkingNumber': prefs.getString(_keyParkingNumber),
      'personName': prefs.getString(_keyPersonName),
      'gangBoss': prefs.getString(_keyGangBoss),
    };
  }

  // Verileri Temizle...
  static Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyTeam);
    await prefs.remove(_keyFlightNumber);
    await prefs.remove(_keyTailNumber);
    await prefs.remove(_keyParkingNumber);
    await prefs.remove(_keyPersonName);
    await prefs.remove(_keyGangBoss);
  }
}
