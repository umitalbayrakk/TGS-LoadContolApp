import 'package:flutter/material.dart';
import 'package:load_control_project/utils/colors.dart';
import 'package:load_control_project/views/control_cart_details/control_card_details_view.dart';
import 'package:load_control_project/views/widgets/appbar/app_bar_widgets.dart';
import 'package:load_control_project/views/widgets/drawer/draver_widgets.dart';
import 'package:intl/intl.dart';
import 'control_list_viewmodel.dart'; // Import the ViewModel

class ControlListPage extends StatefulWidget {
  const ControlListPage({super.key});

  @override
  State<ControlListPage> createState() => _ControlListPageState();
}

class _ControlListPageState extends State<ControlListPage> {
  late final ControlListViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ControlListViewModel();
    _loadDataAndUpdate();
  }

  Future<void> _loadDataAndUpdate() async {
    await _viewModel.loadData();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: AppColors.generalBackground,
      appBar: AppBarWidgets(),
      body: _viewModel.getSavedData().isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      "Henüz Herhangi Bir Load Plan Listelenmedi",
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
            )
          : NewWidget(
              savedData: _viewModel.getSavedData(),
              onDelete: (index) async {
                await _viewModel.deleteData(index);
                if (mounted) setState(() {});
              },
            ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.savedData,
    required this.onDelete,
  });

  final List<Map<String, String>> savedData;
  final Future<void> Function(int) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: savedData.length,
        itemBuilder: (context, index) {
          final entry = savedData[index];
          String dateStr = entry['date'] ?? 'Tarih yok';
          String formattedDate =
              dateStr != 'Tarih yok' ? DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(dateStr)) : dateStr;
          return Card(
            shadowColor: AppColors.borderColor,
            elevation: 2,
            color: AppColors.appBarColor,
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              iconColor: AppColors.removeColor,
              contentPadding: const EdgeInsets.all(10),
              splashColor: AppColors.generalBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              leading: const Column(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.snackBarGreen,
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ControlCardDetailsPage()));
              },
              title: Text(
                'Uçuş No: ${entry['flightNumber']}',
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ekip: ${entry['team']} - Kuyruk: ${entry['tailNumber']} - Park Pozisyonu: ${entry['parkingNumber']}',
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.borderColor),
                  ),
                  Text(
                    'Harekat Memuru: ${entry['personName']} - Postabaşı: ${entry['gangBoss']}',
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.borderColor),
                  ),
                  Text(
                    'Ekleme Tarihi: $formattedDate',
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.removeColor),
                  ),
                ],
              ),
              dense: true,
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: AppColors.removeColor,
                  size: 40,
                ),
                onPressed: () async {
                  bool? confirm = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: AppColors.appBarColor,
                      title: const Text('Silme Onayı'),
                      content: const Text('Bu kaydı silmek istediğinizden emin misiniz?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text(
                            'İptal',
                            style: TextStyle(color: AppColors.borderColor),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text(
                            'Sil',
                            style: TextStyle(color: AppColors.snackBarRed),
                          ),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    await onDelete(index);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}