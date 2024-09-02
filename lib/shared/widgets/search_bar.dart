import 'package:digi_task/core/constants/path/icon_path.dart';
import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/core/utility/extension/icon_path_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.fillColor,
    required this.hintText,
    this.isAnbar,
    required this.onChanged,
    required this.controller,
  });
  final Color fillColor;
  final String hintText;
  final bool? isAnbar;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      style: context.typography.body2Medium.copyWith(color: context.colors.neutralColor10),
      decoration: InputDecoration(
        fillColor: fillColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: context.colors.neutralColor50),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: context.colors.neutralColor50, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: context.colors.neutralColor50),
        ),
        prefixIcon: SvgPicture.asset(
          IconPath.search.toPathSvg,
          fit: BoxFit.none,
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 60,
          minHeight: 48,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: SvgPicture.asset(
            IconPath.filter.toPathSvg,
            fit: BoxFit.none,
          ),
        ),
        hintText: hintText,
        hintStyle: context.typography.body2Regular.copyWith(color: context.colors.neutralColor50),
      ),
    );
  }
}
