import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControlListViewModel {
  List<Map<String, String>> savedData = [];

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? dataList = prefs.getStringList('savedDataList');
    if (dataList != null) {
      savedData = dataList.map((item) => Map<String, String>.from(json.decode(item))).toList();
    } else {
      savedData = [];
    }
  }

  Future<void> deleteData(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? dataList = prefs.getStringList('savedDataList');
    if (dataList != null && index >= 0 && index < dataList.length) {
      dataList.removeAt(index);
      await prefs.setStringList('savedDataList', dataList);
      savedData = dataList.map((item) => Map<String, String>.from(json.decode(item))).toList();
      debugPrint("Silindi: index $index, Yeni savedData: $savedData");
    } else {
      debugPrint("Hata: Veri listesi null veya index geçersiz.");
    }
  }

  List<Map<String, String>> getSavedData() {
    return savedData;
  }
}