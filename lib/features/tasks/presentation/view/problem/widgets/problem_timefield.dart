import 'package:flutter/material.dart';

class TimeSelectionField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isAdmin;
  final VoidCallback? onTap;

  const TimeSelectionField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.isAdmin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              labelText,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: const Icon(
                  Icons.access_time_rounded,
                  color: Colors.blue,
                ),
                hintText: isAdmin ? null : 'Yoxdur',
                hintStyle: TextStyle(
                  color: isAdmin ? Colors.transparent : Colors.grey,
                ),
              ),
              readOnly: !isAdmin,
              onTap: isAdmin ? onTap : null,
            ),
          ],
        ),
      ),
    );
  }
}
