import 'package:digi_task/core/constants/path/icon_path.dart';
import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/core/utility/extension/icon_path_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppField extends StatelessWidget {
  const AppField(
      {super.key,
      required this.title,
      this.controller,
      this.isWithIcon = false,
      this.iconPath,
      this.filledColor,
      this.isProfileView = true,
      this.hintText,
      this.minLine = 1,
      this.maxLine = 1,
      this.onTap,
      this.onlyRead = false,
      this.centerText,
      this.keyboardType = TextInputType.text,
      this.inputFormatters});
  final String title;
  final TextEditingController? controller;
  final bool? isWithIcon;
  final String? iconPath;
  final Color? filledColor;
  final bool? isProfileView;
  final String? hintText;
  final int? minLine;
  final int? maxLine;
  final VoidCallback? onTap;
  final bool? onlyRead;
  final bool? centerText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.typography.body2Regular
              .copyWith(color: context.colors.neutralColor30),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          keyboardType: keyboardType,
          textInputAction: TextInputAction.done,
          textAlign: centerText == true ? TextAlign.center : TextAlign.start,
          readOnly: onlyRead ?? false,
          onTap: onTap,
          minLines: minLine,
          maxLines: maxLine,
          style: context.typography.body2Regular
              .copyWith(color: context.colors.neutralColor10),
          controller: controller,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            suffixIcon: isWithIcon == true
                ? SvgPicture.asset(
                    IconPath.arrowright.toPathSvg,
                    width: 16,
                    height: 16,
                    fit: BoxFit.none,
                  )
                : null,
            prefixIcon: isWithIcon == true
                ? SvgPicture.asset(
                    iconPath ?? IconPath.date.toPathSvg,
                    width: 16,
                    height: 16,
                    fit: BoxFit.none,
                  )
                : null,
            filled: true,
            hintText: isProfileView == true ? null : hintText,
            hintStyle: context.typography.body2SemiBold.copyWith(
                color: isProfileView == true
                    ? context.colors.neutralColor90
                    : context.colors.neutralColor60),
            fillColor: filledColor ?? context.colors.neutralColor100,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius:
                    BorderRadius.circular(isProfileView == true ? 24 : 5)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius:
                    BorderRadius.circular(isProfileView == true ? 24 : 5)),
          ),
        ),
      ],
    );
  }
}
