import 'package:flutter/material.dart';
import 'package:load_control_project/utils/colors.dart';
import 'package:load_control_project/views/control_list_add/category_list_camera/category_list_camera_view.dart';
import 'package:load_control_project/views/control_list_add/category_list_check_box/category_list_check_box_view.dart';
import 'package:load_control_project/views/control_list_add/category_list_info/category_list_info_view.dart';
import 'package:load_control_project/views/control_list_add/category_list_note/category_list_note_view.dart';
import 'package:load_control_project/views/widgets/appbar/app_bar_widgets.dart';
import 'package:load_control_project/views/widgets/drawer/draver_widgets.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int selectedCategoryIndex = 0;

  final List<Map<String, dynamic>> categories = [
    {"title": "", "icon": Icons.info_outline},
    {"title": "", "icon": Icons.check_box_outlined},
    {"title": "", "icon": Icons.note_alt_outlined},
    {"title": "", "icon": Icons.camera_alt_outlined},
  ];

  final List<Widget> pages = [
    const ControlListAddInfo(),
    const ControllerListAddCheckBox(),
    const ControllerListAddNote(),
    const ControllerListAddCamera(),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: AppColors.generalBackground,
      appBar: AppBarWidgets(),
      body: Column(
        children: [
          _buildCategorySelector(colorScheme),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: pages[selectedCategoryIndex],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySelector(ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.generalBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 50,
          width: 325,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final isSelected = selectedCategoryIndex == index;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => setState(() => selectedCategoryIndex = index),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? colorScheme.primary.withOpacity(0.1) : AppColors.generalBackground,
                        borderRadius: BorderRadius.circular(12),
                        border: isSelected
                            ? Border.all(
                                color: AppColors.greenSpot,
                                width: 3,
                              )
                            : null,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      child: Icon(
                        categories[index]["icon"],
                        size: 24,
                        color: isSelected ? AppColors.borderColor : colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
