import 'package:flutter/material.dart';

class DropdownWithIcon extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final String? value;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final bool isAdmin;
  final String? Function(String?)? validator;

  const DropdownWithIcon({
    super.key,
    required this.labelText,
    required this.icon,
    this.value,
    required this.items,
    this.onChanged,
    required this.isAdmin,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(
                icon,
                size: 24.0,
                color: Colors.blue,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: value,
                  onChanged: isAdmin ? onChanged : null,
                  items: items.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: isAdmin ? Colors.black : Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                  ),
                  validator: validator,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
