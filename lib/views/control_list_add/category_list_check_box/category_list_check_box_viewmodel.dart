import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerListAddCheckBoxViewModel {
  String? selectedCargoFlag;
  String? selectedUploadNumber;
  String? selectedInstallationInstructions;
  String? selectedLoadChange;
  String? selectedLoadPlan1;
  String? selectedLoadPlan2;
  String? selectedLoadSheet;

  final List<String> cargoFlag = ["Takılmış", "Takılmamış"];
  final List<String> uploadNumber = ["Yazılmış", "Yazılmamış"];
  final List<String> installationInstructions = ["Yapıldı", "Yapılmadı"];
  final List<String> loadPlan = ["Evet", "Hayır"];
  final List<String> loadSheet = ["Uyumlu", "Uyumsuz"];

  Future<void> saveData(VoidCallback? onSave) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> existingData = prefs.getStringList('savedDataList') ?? [];

    Map<String, String> newEntry = {
      'cargoFlag': selectedCargoFlag ?? '',
      'uploadNumber': selectedUploadNumber ?? '',
      'installationInstructions': selectedInstallationInstructions ?? '',
      'loadChange': selectedLoadChange ?? '',
      'loadPlan1': selectedLoadPlan1 ?? '',
      'loadPlan2': selectedLoadPlan2 ?? '',
      'loadSheet': selectedLoadSheet ?? '',
      'date': DateTime.now().toIso8601String(),
    };

    existingData.add(jsonEncode(newEntry));
    await prefs.setStringList('savedDataList', existingData);
    debugPrint("Kaydedilen Veriler: ${existingData.toString()}");

    if (onSave != null) {
      onSave();
    }

    clearData();
  }

  void clearData() {
    selectedCargoFlag = null;
    selectedUploadNumber = null;
    selectedInstallationInstructions = null;
    selectedLoadChange = null;
    selectedLoadPlan1 = null;
    selectedLoadPlan2 = null;
    selectedLoadSheet = null;
    debugPrint("Form temizlendi");
  }
}