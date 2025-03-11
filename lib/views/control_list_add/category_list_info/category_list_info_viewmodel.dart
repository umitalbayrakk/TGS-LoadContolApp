import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControlListAddInfoViewModel extends ChangeNotifier {
  String? selectedTeam;
  String? selectedFlightNumber;
  String? selectedTailNumber;
  String? selectedParkingNumber;
  String? selectedPersonName;
  String? selectedGangBoss;
  String _snackbarMessage = '';
  bool _isError = false;
  String get snackbarMessage => _snackbarMessage;
  bool get isError => _isError;
  final List<String> teamList = ["A", "B", "C", "D", "E", "F"];
  final List<String> flightNumberList = [
    "TK2023",
    "EK451",
    "LH789",
    "AA1056",
    "BA331",
    "QR872",
    "AF615",
    "SU940",
    "SQ123",
    "JL205",
  ];
  final List<String> tailNumberList = [
    "N123AB",
    "D-ABCD",
    "TC-ABC",
    "A6-BCD",
    "RA-12345",
    "VH-ABC",
    "JA123A",
    "C-GABC",
    "F-ABCD",
    "G-ABCD",
  ];
  final List<String> parkingNumberList = [
    "Gate A12",
    "Stand B5",
    "Apron North 7",
    "Remote Stand R3",
    "Cargo Stand C8",
    "Bay 42",
    "Terminal 3, Stand T3-15",
    "VIP Stand V2",
    "Main Apron M7",
    "De-icing Stand D4",
  ];
  final List<String> personNameList = [
    "Emre Kaya",
    "Aylin Demir",
    "Deniz Yılmaz",
    "Cem Aksoy",
    "Ebru Tekin",
    "Ana Silva",
    "Zeynep Arslan",
    "Olivier Dubois",
    "Sophia Müller",
    "Elena Costa",
  ];
  final List<String> gangBossList = [
    "Ahmet Yıldırım ",
    "Elena Martinez ",
    "Okan Demir ",
    "Liam O'Connor",
    "Zeynep Korkmaz ",
    "Sergei Ivanov ",
  ];

  final List<String> cargoFlag = [
    "Takılmış",
    "Takılmamış",
  ];

  final List<String> uploadNumber = [
    "Yazılmış",
    "Yazılmamış",
  ];

  final List<String> installationInstructions = [
    "Yapıldı",
    "Yapılmadı",
  ];

  final List<String> loadPlan = [
    "Evet",
    "Hayır",
  ];
  final List<String> loadSheet = [
    "Uyumlu",
    "Uyumsuz",
  ];

  Future<void> saveData(VoidCallback? onSave) async {
    if (_isFormIncomplete()) {
      updateSnackbar("Lütfen tüm alanları doldurun.", true);
    } else {
      try {
        final prefs = await SharedPreferences.getInstance();
        List<String> existingData = prefs.getStringList('savedDataList') ?? [];
        Map<String, String> newEntry = {
          'team': selectedTeam ?? '',
          'flightNumber': selectedFlightNumber ?? '',
          'tailNumber': selectedTailNumber ?? '',
          'parkingNumber': selectedParkingNumber ?? '',
          'personName': selectedPersonName ?? '',
          'gangBoss': selectedGangBoss ?? '',
          'date': DateTime.now().toIso8601String(),
        };
        existingData.add(jsonEncode(newEntry));
        await prefs.setStringList('savedDataList', existingData);
        debugPrint("Kaydedilen Veriler: ${existingData.toString()}");
        updateSnackbar("Başarıyla kaydedildi.", false);
        if (onSave != null) onSave();
        clearData();
      } catch (e) {
        debugPrint("Hata: $e");
        updateSnackbar("Kaydetme sırasında hata oluştu.", true);
      }
    }
    notifyListeners();
  }

  void clearData() {
    selectedTeam = null;
    selectedFlightNumber = null;
    selectedTailNumber = null;
    selectedParkingNumber = null;
    selectedPersonName = null;
    selectedGangBoss = null;
    updateSnackbar("Veriler temizlendi.", false);
    notifyListeners();
  }

  void updateField(String field, String? value) {
    switch (field) {
      case 'team':
        selectedTeam = value;
        break;
      case 'flightNumber':
        selectedFlightNumber = value;
        break;
      case 'tailNumber':
        selectedTailNumber = value;
        break;
      case 'parkingNumber':
        selectedParkingNumber = value;
        break;
      case 'personName':
        selectedPersonName = value;
        break;
      case 'gangBoss':
        selectedGangBoss = value;
        break;
    }
    notifyListeners();
  }

  bool _isFormIncomplete() {
    return [
      selectedTeam,
      selectedFlightNumber,
      selectedTailNumber,
      selectedParkingNumber,
      selectedPersonName,
      selectedGangBoss
    ].contains(null);
  }

  void updateSnackbar(String message, bool isError) {
    _snackbarMessage = message;
    _isError = isError;
  }
}
//test@gmail.com