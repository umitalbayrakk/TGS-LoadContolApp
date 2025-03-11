import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ControlCardDetailsViewModel {
  Future<List<Map<String, dynamic>>> loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedData = prefs.getStringList('savedDataList') ?? [];
    return savedData.map((item) => jsonDecode(item) as Map<String, dynamic>).toList();
  }

  Future<void> deleteItem(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedData = prefs.getStringList('savedDataList') ?? [];

    if (index >= 0 && index < savedData.length) {
      savedData.removeAt(index);
      await prefs.setStringList('savedDataList', savedData);
    }
  }

  String formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
    } catch (e) {
      return dateString;
    }
  }
}