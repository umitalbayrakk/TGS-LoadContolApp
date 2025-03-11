import 'dart:io';
import 'package:flutter/material.dart';
import 'package:load_control_project/utils/colors.dart';
import 'control_card_details_viewmodel.dart'; // Import the ViewModel

class ControlCardDetailsPage extends StatefulWidget {
  const ControlCardDetailsPage({super.key});

  @override
  State<ControlCardDetailsPage> createState() => _ControlCardDetailsPageState();
}

class _ControlCardDetailsPageState extends State<ControlCardDetailsPage> {
  late final ControlCardDetailsViewModel _viewModel;
  late Future<List<Map<String, dynamic>>> _savedDataFuture;

  @override
  void initState() {
    super.initState();
    _viewModel = ControlCardDetailsViewModel();
    _savedDataFuture = _viewModel.loadSavedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.generalBackground,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.whiteSpot, size: 24),
        title: const Text(
          'Detaylar',
          style: TextStyle(
            color: AppColors.whiteSpot,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: AppColors.snackBarRed,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _savedDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Veri yüklenirken hata oluştu'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      "Henüz Herhangi Bir Load Plan Detayı Eklenmedi",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Icon(
                    Icons.error,
                    size: 100,
                    color: AppColors.snackBarRed,
                  ),
                ],
              ),
            );
          }
          final savedItems = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: savedItems.length,
            itemBuilder: (context, index) {
              final item = savedItems[index];
              return Card(
                color: AppColors.appBarColor,
                margin: const EdgeInsets.only(bottom: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item.containsKey('imagePath') && File(item['imagePath']).existsSync())
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(item['imagePath']),
                            width: 400,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailRow('Not', item['kaydedilenmesaj']),
                          _buildDetailRow('Checkbox Durumları', item['controllerListCheckBox']?.toString()),
                          _buildDetailRow('Kargo Flaması', item['cargoFlag']),
                          _buildDetailRow('Yükleme Numarası', item['uploadNumber']),
                          _buildDetailRow('Yükleme Talimatları', item['installationInstructions']),
                          _buildDetailRow('Yükleme Değişikliği', item['loadChange']),
                          _buildDetailRow('1. Load Plan', item['loadPlan1']),
                          _buildDetailRow('2. Load Plan Teslim', item['loadPlan2']),
                          _buildDetailRow('Loadsheet Uyumluluğu', item['loadSheet']),
                          _buildDetailRow('Tarih', _viewModel.formatDate(item['date'])),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Delete button
                      Align(
                        alignment: Alignment.centerRight,
                        child: MaterialButton(
                          height: 50,
                          minWidth: 100,
                          onPressed: () async {
                            await _viewModel.deleteItem(index);
                            setState(() {
                              _savedDataFuture = _viewModel.loadSavedData();
                            });
                          },
                          color: AppColors.greenSpot,
                          child: const Text(
                            "Sil",
                            style: TextStyle(
                              color: AppColors.whiteSpot,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.borderColor,
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'Belirtilmemiş',
              style: const TextStyle(color: AppColors.borderColor),
            ),
          ),
        ],
      ),
    );
  }
}