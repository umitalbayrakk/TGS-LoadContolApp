import 'package:flutter/material.dart';
import 'package:load_control_project/utils/colors.dart';
import 'package:load_control_project/views/control_cart_details/control_card_details_view.dart';
import 'package:load_control_project/views/control_list_add/category_list_camera/category_list_camera_viewmodel.dart';
import 'package:load_control_project/views/widgets/snackbar/snackbar_widgets.dart';
import 'package:image_picker/image_picker.dart';

class ControllerListAddCamera extends StatefulWidget {
  const ControllerListAddCamera({super.key});

  @override
  State<ControllerListAddCamera> createState() => _ControllerListAddCameraState();
}

class _ControllerListAddCameraState extends State<ControllerListAddCamera> {
  late final ControllerListAddCameraViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ControllerListAddCameraViewModel();
    _viewModel.loadImagePath().then((_) {
      if (mounted) setState(() {}); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.generalBackground,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _viewModel.selectedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      _viewModel.selectedImage!,
                      width: 400,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Text(
                    'Henüz resim seçilmedi',
                    style: TextStyle(
                      color: AppColors.borderColor,
                      fontSize: 16,
                    ),
                  ),
            const SizedBox(height: 30),
            Center(
              child: MaterialButton(
                height: 50,
                minWidth: 300,
                onPressed: () async {
                  await _viewModel.pickImage(ImageSource.gallery);
                  if (mounted) setState(() {});
                },
                color: AppColors.greenSpot,
                child: const Text(
                  "Galeriden Resim Seç",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              height: 50,
              minWidth: 300,
              onPressed: () async {
                await _viewModel.pickImage(ImageSource.camera);
                if (mounted) setState(() {});
              },
              color: AppColors.greenSpot,
              child: const Text(
                "Kamera İle Fotoğraf Çek",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              height: 50,
              minWidth: 300,
              onPressed: () async {
                if (_viewModel.selectedImage == null) {
                  showCustomSnackbar(context, "Kaydedilecek resim yok!", isError: true);
                  return;
                }
                await _viewModel.saveImagePath();
                showCustomSnackbar(context, "Fotoğraf başarılı bir şekilde kaydedildi", isError: false);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ControlCardDetailsPage()),
                );
              },
              color: AppColors.greenSpot,
              child: const Text(
                "Fotoğrafı Kaydet",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}