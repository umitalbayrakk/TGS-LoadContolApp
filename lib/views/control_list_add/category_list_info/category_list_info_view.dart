import 'package:flutter/material.dart';
import 'package:load_control_project/utils/colors.dart';
import 'package:load_control_project/views/control_list_add/category_list_info/category_list_info_viewmodel.dart';
import 'package:load_control_project/views/widgets/dropdownmenu/custom_dropdownmenu.dart';
import 'package:load_control_project/views/widgets/navbar/custom_navbar_widgets.dart';
import 'package:load_control_project/views/widgets/snackbar/snackbar_widgets.dart';
import 'package:provider/provider.dart';

class ControlListAddInfo extends StatelessWidget {
  final VoidCallback? onSave;

  const ControlListAddInfo({super.key, this.onSave});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ControlListAddInfoViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.generalBackground,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<ControlListAddInfoViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.snackbarMessage.isNotEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showCustomSnackbar(context, viewModel.snackbarMessage, isError: viewModel.isError);
                    viewModel.updateSnackbar('', false);
                  });
                }
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomDropdownMenu(
                            categories: viewModel.teamList,
                            title: "Ekip",
                            hintText: "Ekip seçin",
                            value: viewModel.selectedTeam,
                            onChanged: (value) => viewModel.updateField('team', value),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomDropdownMenu(
                            categories: viewModel.flightNumberList,
                            title: "Uçuş No",
                            hintText: "Uçuş numarası seçin",
                            value: viewModel.selectedFlightNumber,
                            onChanged: (value) => viewModel.updateField('flightNumber', value),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: CustomDropdownMenu(
                            categories: viewModel.tailNumberList,
                            title: "Kuyruk",
                            hintText: "Kuyruk numarası seçin",
                            value: viewModel.selectedTailNumber,
                            onChanged: (value) => viewModel.updateField('tailNumber', value),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomDropdownMenu(
                            categories: viewModel.parkingNumberList,
                            title: "Park Pozisyonu",
                            hintText: "Park pozisyonu seçin",
                            value: viewModel.selectedParkingNumber,
                            onChanged: (value) => viewModel.updateField('parkingNumber', value),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: CustomDropdownMenu(
                            categories: viewModel.personNameList,
                            title: "Harekat Memuru",
                            hintText: "İsim seçin",
                            value: viewModel.selectedPersonName,
                            onChanged: (value) => viewModel.updateField('personName', value),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomDropdownMenu(
                            categories: viewModel.gangBossList,
                            title: "Postabaşı",
                            hintText: "Postabaşı seçin",
                            value: viewModel.selectedGangBoss,
                            onChanged: (value) => viewModel.updateField('gangBoss', value),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          height: 50,
                          minWidth: 150,
                          onPressed: () async {
                            await viewModel.saveData(() {
                              debugPrint("onSave tetiklendi");
                              onSave?.call();
                            });
                            if (!viewModel.isError) {
                              debugPrint("Kaydet başarılı, geri dönülüyor");
                              // Burada yapılan tetikleme ile  load plan listelemede card widget ı güncelledik.
                              Navigator.push(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  MaterialPageRoute(builder: (context) => const CustomNavbarWidgets()));
                              debugPrint("Kaydet başarısız: ${viewModel.snackbarMessage}");
                            }
                          },
                          color: AppColors.greenSpot,
                          child: const Text(
                            "Kaydet",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        const SizedBox(width: 20),
                        MaterialButton(
                          height: 50,
                          minWidth: 150,
                          onPressed: viewModel.clearData,
                          color: AppColors.whitecolorSpot,
                          child: const Text(
                            "Vazgeç",
                            style: TextStyle(color: AppColors.borderColor, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
