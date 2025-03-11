import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ControllerListAddCameraViewModel {
  File? _selectedImage;

  File? get selectedImage => _selectedImage;

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        _selectedImage = File(pickedImage.path);
      }
    } catch (e) {
      print("Resim seçilemedi: $e");
    }
  }

  Future<void> saveImagePath() async {
    if (_selectedImage == null) {
      return; 
    }

    final prefs = await SharedPreferences.getInstance();
    List<String> savedData = prefs.getStringList('savedDataList') ?? [];

    Map<String, dynamic> data = {
      'imagePath': _selectedImage!.path,
      'date': DateTime.now().toIso8601String(),
    };

    savedData.add(jsonEncode(data));
    await prefs.setStringList('savedDataList', savedData);
  }

  Future<void> loadImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('saved_image_path');
    if (imagePath != null && File(imagePath).existsSync()) {
      _selectedImage = File(imagePath);
    }
  }
}