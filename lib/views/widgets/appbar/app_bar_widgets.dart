
import 'package:flutter/material.dart';
import 'package:load_control_project/utils/colors.dart';

class AppBarWidgets extends StatelessWidget implements PreferredSizeWidget {
   AppBarWidgets({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(56.0);

    

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: AppColors.whiteSpot),
      backgroundColor: AppColors.greenSpot,
      elevation: 8,
      shadowColor: Colors.black,
      surfaceTintColor: Colors.transparent,
      title: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.flight_takeoff, size: 32),
          SizedBox(width: 12),
          Text(
            "TGS",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: AppColors.whiteSpot,
              letterSpacing: 4.0,
            ),
          ),
          SizedBox(width: 8),
          CircleAvatar(
            
            radius: 4,
            backgroundColor: AppColors.whiteSpot,
          ),
        ],
      ),
      centerTitle: true,
    );
  }
}
