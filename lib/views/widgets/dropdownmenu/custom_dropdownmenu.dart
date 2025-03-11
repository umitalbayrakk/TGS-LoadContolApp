import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatelessWidget {
  final List<String> categories;
  final String hintText;
  final String title;
  final String? subtitle;
  final Function(String?) onChanged;
  final double width;

  const CustomDropdownMenu({
    super.key,
    required this.categories,
    required this.onChanged,
    this.hintText = "Seçiniz",
    required this.title,
    this.subtitle,
    this.width = 180,
    String? value,
  });

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry<String>> dropdownItems =
        categories.map((category) => DropdownMenuEntry(value: category, label: category)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
        const SizedBox(height: 8),
        DropdownMenu<String>(
          width: width,
          hintText: hintText,
          dropdownMenuEntries: dropdownItems,
          onSelected: onChanged,
        ),
      ],
    );
  }
}
