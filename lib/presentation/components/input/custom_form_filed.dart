import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField(
      {super.key, required this.title, required this.icon, required this.hintText, required this.controller});
  final String title;
  final IconData icon;
  final String hintText;
final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.typography.body2SemiBold.copyWith(
            color: context.colors.neutralColor40,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        TextFormField(
          controller: controller,
          style: context.typography.body2SemiBold.copyWith(
            color: context.colors.neutralColor30,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: context.typography.body2Regular.copyWith(
              color: context.colors.neutralColor70,
            ),
            contentPadding: const EdgeInsets.all(16),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: context.colors.neutralColor50),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: context.colors.neutralColor80),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: context.colors.neutralColor80),
              borderRadius: BorderRadius.circular(8),
            ),
            prefixIcon: Icon(
              icon,
              color: context.colors.neutralColor50,
            ),
          ),
        ),
      ],
    );
  }
}
