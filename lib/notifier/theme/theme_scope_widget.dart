import 'package:digi_task/notifier/theme/theme_scope.dart';
import 'package:flutter/material.dart';

import '../../core/constants/theme/app_colors.dart';
import '../../core/constants/theme/app_typography.dart';

class ThemeScopeWidget extends StatefulWidget {
  const ThemeScopeWidget({
    super.key,
    required this.child,
  });

  final Widget child;
  static ThemeScopeWidgetState? of(BuildContext context) {
    return context.findRootAncestorStateOfType<ThemeScopeWidgetState>();
  }

  @override
  State<ThemeScopeWidget> createState() => ThemeScopeWidgetState();
}

class ThemeScopeWidgetState extends State<ThemeScopeWidget> {
  final String nunitoFontFamily = 'NunitoSans';
  final String montserratFontFamily = 'Montserrat';

  @override
  Widget build(BuildContext context) {
    final appColors = AppLightColors();

    final appTypography = AppTypography(
        body1Light: TextStyle(
          fontFamily: nunitoFontFamily,
          fontSize: 18,
          height: 22 / 18,
          fontWeight: FontWeight.w300,
        ),
        body2Light: TextStyle(
          fontFamily: nunitoFontFamily,
          fontSize: 16,
          height: 20 / 16,
          fontWeight: FontWeight.w300,
        ),
        body1Regular: TextStyle(
          fontFamily: nunitoFontFamily,
          fontSize: 18,
          height: 22 / 18,
          fontWeight: FontWeight.w400,
        ),
        body2Regular: TextStyle(
          fontFamily: nunitoFontFamily,
          fontSize: 16,
          height: 20 / 16,
          fontWeight: FontWeight.w400,
        ),
        body1Medium: TextStyle(
          fontFamily: nunitoFontFamily,
          fontSize: 18,
          height: 22 / 18,
          fontWeight: FontWeight.w500,
        ),
        body2Medium: TextStyle(
          fontFamily: nunitoFontFamily,
          fontSize: 16,
          height: 20 / 16,
          fontWeight: FontWeight.w500,
        ),
        body1SemiBold: TextStyle(
          fontFamily: nunitoFontFamily,
          fontSize: 18,
          height: 22 / 18,
          fontWeight: FontWeight.w700,
        ),
        body2SemiBold: TextStyle(
          fontFamily: nunitoFontFamily,
          fontSize: 16,
          height: 20 / 16,
          fontWeight: FontWeight.w700,
        ),
        h1Light: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 72,
          height: 90 / 72,
          fontWeight: FontWeight.w300,
        ),
        h2Light: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 60,
          height: 75 / 60,
          fontWeight: FontWeight.w300,
        ),
        h3Light: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 48,
          height: 60 / 48,
          fontWeight: FontWeight.w300,
        ),
        h4Light: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 36,
          height: 45 / 36,
          fontWeight: FontWeight.w300,
        ),
        h5Light: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 28,
          height: 36 / 28,
          fontWeight: FontWeight.w300,
        ),
        h6Light: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 24,
          height: 30 / 24,
          fontWeight: FontWeight.w300,
        ),
        h1Regular: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 72,
          height: 90 / 72,
          fontWeight: FontWeight.w400,
        ),
        h2Regular: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 60,
          height: 75 / 60,
          fontWeight: FontWeight.w400,
        ),
        h3Regular: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 48,
          height: 60 / 48,
          fontWeight: FontWeight.w400,
        ),
        h4Regular: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 36,
          height: 45 / 36,
          fontWeight: FontWeight.w400,
        ),
        h5Regular: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 28,
          height: 36 / 28,
          fontWeight: FontWeight.w400,
        ),
        h6Regular: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 24,
          height: 30 / 24,
          fontWeight: FontWeight.w400,
        ),
        h1Medium: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 72,
          height: 90 / 72,
          fontWeight: FontWeight.w500,
        ),
        h2Medium: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 60,
          height: 75 / 60,
          fontWeight: FontWeight.w500,
        ),
        h3Medium: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 48,
          height: 60 / 48,
          fontWeight: FontWeight.w500,
        ),
        h4Medium: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 36,
          height: 45 / 36,
          fontWeight: FontWeight.w500,
        ),
        h5Medium: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 28,
          height: 36 / 28,
          fontWeight: FontWeight.w500,
        ),
        h6Medium: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 24,
          height: 30 / 24,
          fontWeight: FontWeight.w500,
        ),
        h1SemiBold: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 72,
          height: 90 / 72,
          fontWeight: FontWeight.w700,
        ),
        h2SemiBold: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 60,
          height: 75 / 60,
          fontWeight: FontWeight.w700,
        ),
        h3SemiBold: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 48,
          height: 60 / 48,
          fontWeight: FontWeight.w700,
        ),
        h4SemiBold: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 36,
          height: 45 / 36,
          fontWeight: FontWeight.w700,
        ),
        h5SemiBold: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 28,
          height: 36 / 28,
          fontWeight: FontWeight.w700,
        ),
        h6SemiBold: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 24,
          height: 30 / 24,
          fontWeight: FontWeight.w700,
        ),
        captionLight: TextStyle(
          fontFamily: nunitoFontFamily,
          fontSize: 14,
          height: 20 / 14,
          fontWeight: FontWeight.w300,
        ),
        captionRegular: TextStyle(
          fontFamily: nunitoFontFamily,
          fontSize: 14,
          height: 20 / 14,
          fontWeight: FontWeight.w400,
        ),
        captionMedium: TextStyle(
          fontFamily: nunitoFontFamily,
          fontSize: 14,
          height: 20 / 14,
          fontWeight: FontWeight.w500,
        ),
        captionSemiBold: TextStyle(
          fontFamily: nunitoFontFamily,
          fontSize: 14,
          height: 20 / 14,
          fontWeight: FontWeight.w700,
        ),
        overlineLight: TextStyle(
          fontFamily: nunitoFontFamily,
          fontSize: 12,
          height: 16 / 12,
          fontWeight: FontWeight.w300,
        ),
        overlineRegular: TextStyle(
          fontFamily: nunitoFontFamily,
          fontSize: 12,
          height: 16 / 12,
          fontWeight: FontWeight.w400,
        ),
        overlineMedium: TextStyle(
          fontFamily: nunitoFontFamily,
          fontSize: 12,
          height: 16 / 12,
          fontWeight: FontWeight.w500,
        ),
        overlineSemiBold: TextStyle(
          fontFamily: nunitoFontFamily,
          fontSize: 12,
          height: 16 / 12,
          fontWeight: FontWeight.w700,
        ),
        subtitle1Light: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 22,
          height: 28 / 22,
          fontWeight: FontWeight.w300,
        ),
        subtitle1Regular: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 22,
          height: 28 / 22,
          fontWeight: FontWeight.w400,
        ),
        subtitle1Medium: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 22,
          height: 28 / 22,
          fontWeight: FontWeight.w500,
        ),
        subtitle1SemiBold: TextStyle(
            fontFamily: montserratFontFamily,
            fontSize: 22,
            height: 28 / 22,
            fontWeight: FontWeight.w700,
            color: Colors.black),
        subtitle2Light: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 20,
          height: 26 / 20,
          fontWeight: FontWeight.w300,
        ),
        subtitle2Regular: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 20,
          height: 26 / 20,
          fontWeight: FontWeight.w400,
        ),
        subtitle2Medium: TextStyle(
            fontFamily: montserratFontFamily,
            fontSize: 20,
            height: 26 / 20,
            fontWeight: FontWeight.w500,
            color: appColors.neutralColor10),
        subtitle2SemiBold: TextStyle(
          fontFamily: montserratFontFamily,
          fontSize: 20,
          height: 26 / 20,
          fontWeight: FontWeight.w700,
        ));
    return ThemeScope(
      appColors: appColors,
      appTypography: appTypography,
      child: widget.child,
    );
  }
}
