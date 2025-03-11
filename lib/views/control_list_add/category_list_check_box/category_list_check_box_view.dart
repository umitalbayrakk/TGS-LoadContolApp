import 'package:flutter/material.dart';
import 'package:load_control_project/utils/colors.dart';
import 'package:load_control_project/views/control_list_add/category_list_check_box/category_list_check_box_viewmodel.dart';
import 'package:load_control_project/views/widgets/dropdownmenu/custom_dropdownmenu.dart';
import 'package:load_control_project/views/widgets/snackbar/snackbar_widgets.dart';

class ControllerListAddCheckBox extends StatefulWidget {
  final VoidCallback? onSave;
  const ControllerListAddCheckBox({super.key, this.onSave});

  @override
  State<ControllerListAddCheckBox> createState() => _ControllerListAddCheckBoxState();
}

class _ControllerListAddCheckBoxState extends State<ControllerListAddCheckBox> {
  late final ControllerListAddCheckBoxViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ControllerListAddCheckBoxViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.generalBackground,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: CustomDropdownMenu(
                    categories: _viewModel.cargoFlag,
                    title: "Kargo Flaması",
                    hintText: "Kargo Flaması seçin",
                    value: _viewModel.selectedCargoFlag,
                    onChanged: (value) => setState(() {
                      _viewModel.selectedCargoFlag = value;
                    }),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomDropdownMenu(
                    categories: _viewModel.uploadNumber,
                    title: "Yükleme Numarası",
                    hintText: "Yükleme Numarası seçin",
                    value: _viewModel.selectedUploadNumber,
                    onChanged: (value) => setState(() {
                      _viewModel.selectedUploadNumber = value;
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomDropdownMenu(
                    categories: _viewModel.installationInstructions,
                    title: "Yükleme Talimatları",
                    hintText: "Yükleme Talimatları seçin",
                    value: _viewModel.selectedInstallationInstructions,
                    onChanged: (value) => setState(() {
                      _viewModel.selectedInstallationInstructions = value;
                    }),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomDropdownMenu(
                    categories: _viewModel.installationInstructions,
                    title: "Yükleme Değişikliği",
                    hintText: "Yükleme Değişikliği seçin",
                    value: _viewModel.selectedLoadChange,
                    onChanged: (value) => setState(() {
                      _viewModel.selectedLoadChange = value;
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomDropdownMenu(
                    categories: _viewModel.loadPlan,
                    title: "1.Load Plan ve 2.Load Plan\nSicil- imza- saat",
                    hintText: "1.Load Plan ve 2.Load Plan Sicil- imza- saat seçin",
                    value: _viewModel.selectedLoadPlan1,
                    onChanged: (value) => setState(() {
                      _viewModel.selectedLoadPlan1 = value;
                    }),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomDropdownMenu(
                    categories: _viewModel.loadPlan,
                    title: "2.Load plan loadsheet\nalınmadan Teslim:",
                    hintText: "2.Load plan loadsheet alınmadan Teslim Seçin",
                    value: _viewModel.selectedLoadPlan2,
                    onChanged: (value) => setState(() {
                      _viewModel.selectedLoadPlan2 = value;
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: CustomDropdownMenu(
                    categories: _viewModel.loadSheet,
                    title: "Loadsheet-Loadplan Uygunluğu",
                    hintText: "Loadsheet-Loadplan Uygunluğu",
                    value: _viewModel.selectedLoadSheet,
                    onChanged: (value) => setState(() {
                      _viewModel.selectedLoadSheet = value;
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                  height: 50,
                  minWidth: 150,
                  onPressed: () async {
                    await _viewModel.saveData(widget.onSave);
                    showCustomSnackbar(context, "Başarılı Bir Şekilde Kaydedildi", isError: false);
                    setState(() {}); // UI'yi güncellemek için
                  },
                  color: AppColors.greenSpot,
                  child: const Text(
                    "Kaydet",
                    style: TextStyle(
                      color: AppColors.whiteSpot,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                MaterialButton(
                  height: 50,
                  minWidth: 150,
                  onPressed: () {
                    _viewModel.clearData();
                    showCustomSnackbar(context, "Başarılı Bir Şekilde Temizlendi", isError: false);
                    setState(() {});
                  },
                  color: AppColors.whitecolorSpot,
                  child: const Text(
                    "Vazgeç",
                    style: TextStyle(
                      color: AppColors.borderColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}