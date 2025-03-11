import 'package:flutter/material.dart';
import 'package:load_control_project/utils/colors.dart';
import 'package:load_control_project/views/feedback/feedback_page.dart';
import 'package:load_control_project/views/login/login_page.dart';
import 'package:load_control_project/views/settings/settings_page_view.dart';
import 'package:load_control_project/views/widgets/drawer/drawer_viewmodel.dart';
import 'package:load_control_project/views/widgets/snackbar/snackbar_widgets.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late final CustomDrawerViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = CustomDrawerViewModel();
    _viewModel.loadImage().then((_) {
      if (mounted) setState(() {}); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.greenSpot,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    await _viewModel.pickImage();
                    if (mounted) setState(() {}); 
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: _viewModel.image != null && _viewModel.image!.existsSync()
                        ? FileImage(_viewModel.image!)
                        : null,
                    child: _viewModel.image == null ? const Icon(Icons.person, size: 30) : null,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Kullanıcı Adı',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const Text(
                  'tgs@aeo.com',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Ayarlar'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPageView()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Geri Bildirim'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const FeedbackPage()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Çıkış Yap'),
            onTap: () {
              showCustomSnackbar(context, "Başarılı Bir Şekilde Çıkış Yapıldı", isError: true);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
