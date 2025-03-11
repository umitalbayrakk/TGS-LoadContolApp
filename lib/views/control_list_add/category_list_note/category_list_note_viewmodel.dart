import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerListAddNoteViewModel extends ChangeNotifier {
  
  final TextEditingController controller = TextEditingController();
  bool _isError = false;
  String _snackbarMessage = '';
  String get snackbarMessage => _snackbarMessage;
  bool get isError => _isError;

  Future<void> saveData(BuildContext context, VoidCallback? onSave) async {
    String message = controller.text.trim();
    if (message.isEmpty) {
      updateSnackbar("Lütfen bir not girin!", true);
      notifyListeners();
      return;
    }
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> existingData = prefs.getStringList('savedDataList') ?? [];

      Map<String, String> newEntry = {
        'kaydedilenmesaj': message,
        'date': DateTime.now().toIso8601String(),
      };
      existingData.add(jsonEncode(newEntry));
      await prefs.setStringList('savedDataList', existingData);
      debugPrint("Kaydedilen Veriler: ${existingData.toString()}");

      updateSnackbar("Başarılı Bir Şekilde Kaydedildi", false);
      if (onSave != null) {
        onSave();
      }
      controller.clear();
    } catch (e) {
      debugPrint("Hata oluştu: $e");
      updateSnackbar("Kaydetme sırasında bir hata oluştu!", true);
    }
    notifyListeners();
  }

  void updateSnackbar(String message, bool isError) {
    _snackbarMessage = message;
    _isError = isError;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
