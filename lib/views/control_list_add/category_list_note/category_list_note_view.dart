import 'package:flutter/material.dart';
import 'package:load_control_project/utils/colors.dart';
import 'package:load_control_project/views/control_list_add/category_list_note/category_list_note_viewmodel.dart';
import 'package:load_control_project/views/widgets/snackbar/snackbar_widgets.dart';
import 'package:provider/provider.dart';


class ControllerListAddNote extends StatelessWidget {
  final VoidCallback? onSave;

  const ControllerListAddNote({super.key, this.onSave});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ControllerListAddNoteViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.generalBackground,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Consumer<ControllerListAddNoteViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.snackbarMessage.isNotEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showCustomSnackbar(context, viewModel.snackbarMessage, isError: viewModel.isError);
                    viewModel.updateSnackbar('', false); 
                  });
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: viewModel.controller,
                      maxLines: 15,
                      decoration: const InputDecoration(
                        hintText: "Notunuzu yazın...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    MaterialButton(
                      height: 50,
                      minWidth: 300,
                      onPressed: () => viewModel.saveData(context, onSave),
                      color: AppColors.greenSpot,
                      child: const Text(
                        "Kaydet",
                        style: TextStyle(
                          color: AppColors.whiteSpot,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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