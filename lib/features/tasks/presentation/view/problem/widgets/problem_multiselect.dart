import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';

class MultiSelectWithIcon extends StatelessWidget {
  final IconData? icon;
  final String labelText;
  final ValueChanged<List<String>> onChanged;
  final List<String> items;
  final bool isAdmin;
  final List<String> options;
  final String? emptyText;

  const MultiSelectWithIcon({
    super.key,
    this.icon,
    required this.labelText,
    required this.onChanged,
    required this.items,
    required this.isAdmin,
    required this.options,
    this.emptyText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              if (icon != null) Icon(icon, size: 24.0, color: Colors.blue),
              const SizedBox(width: 8),
              Expanded(
                child: IgnorePointer(
                  ignoring: !isAdmin,
                  child: DropDownMultiSelect(
                    onChanged: onChanged,
                    whenEmpty: emptyText,
                    options: options,
                    selectedValues: items,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),

                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
