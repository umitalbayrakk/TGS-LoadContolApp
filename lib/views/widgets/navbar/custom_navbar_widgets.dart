import 'package:flutter/material.dart';
import 'package:load_control_project/utils/colors.dart';
import 'package:load_control_project/views/control_list_add/category_page_list_add.dart';
import 'package:load_control_project/views/control_list_page/control_list_view.dart';

class CustomNavbarWidgets extends StatefulWidget {
  const CustomNavbarWidgets({super.key});

  @override
  State<CustomNavbarWidgets> createState() => _CustomNavbarWidgetsState();
}

class _CustomNavbarWidgetsState extends State<CustomNavbarWidgets> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: const [
                ControlListPage(),
                CategoryScreen(),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: ClipRRect(
              child: BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
                items: [
                  BottomNavigationBarItem(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _selectedIndex == 0 ? AppColors.whiteSpot.withOpacity(0.2) : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.list_alt,
                        size: 32,
                        color: _selectedIndex == 0 ? AppColors.whiteSpot : AppColors.greySpot,
                      ),
                    ),
                    label: "Load Plan Listeleme",
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _selectedIndex == 1 ? AppColors.whiteSpot.withOpacity(0.2) : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.add_box,
                        size: 32,
                        color: _selectedIndex == 1 ? AppColors.whiteSpot : AppColors.greySpot,
                      ),
                    ),
                    label: "Load Plan Ekleme",
                  ),
                ],
                backgroundColor: AppColors.greenSpot,
                selectedItemColor: AppColors.whiteSpot,
                unselectedItemColor: AppColors.greySpot,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
