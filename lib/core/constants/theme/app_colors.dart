import 'package:flutter/material.dart';

interface class AppColors extends ThemeExtension<AppColors> {
  AppColors({
    required this.primaryColor0,
    required this.primaryColor10,
    required this.primaryColor20,
    required this.primaryColor30,
    required this.primaryColor40,
    required this.primaryColor50,
    required this.primaryColor60,
    required this.primaryColor70,
    required this.primaryColor80,
    required this.primaryColor90,
    required this.primaryColor95,
    required this.primaryColor99,
    required this.primaryColor100,
    required this.secondaryColor0,
    required this.secondaryColor10,
    required this.secondaryColor20,
    required this.secondaryColor30,
    required this.secondaryColor40,
    required this.secondaryColor50,
    required this.secondaryColor60,
    required this.secondaryColor70,
    required this.secondaryColor80,
    required this.secondaryColor90,
    required this.secondaryColor95,
    required this.secondaryColor99,
    required this.secondaryColor100,
    required this.successColor0,
    required this.successColor10,
    required this.successColor20,
    required this.successColor30,
    required this.successColor40,
    required this.successColor50,
    required this.successColor60,
    required this.successColor70,
    required this.successColor80,
    required this.successColor90,
    required this.successColor95,
    required this.successColor99,
    required this.successColor100,
    required this.errorColor0,
    required this.errorColor10,
    required this.errorColor20,
    required this.errorColor30,
    required this.errorColor40,
    required this.errorColor50,
    required this.errorColor60,
    required this.errorColor70,
    required this.errorColor80,
    required this.errorColor90,
    required this.errorColor95,
    required this.errorColor99,
    required this.errorColor100,
    required this.neutralColor0,
    required this.neutralColor10,
    required this.neutralColor20,
    required this.neutralColor30,
    required this.neutralColor40,
    required this.neutralColor50,
    required this.neutralColor60,
    required this.neutralColor70,
    required this.neutralColor80,
    required this.neutralColor90,
    required this.neutralColor95,
    required this.neutralColor99,
    required this.neutralColor100,
    required this.backgroundColor,
  });
  //primary colors
  final Color primaryColor0;
  final Color primaryColor10;
  final Color primaryColor20;
  final Color primaryColor30;
  final Color primaryColor40;
  final Color primaryColor50;
  final Color primaryColor60;
  final Color primaryColor70;
  final Color primaryColor80;
  final Color primaryColor90;
  final Color primaryColor95;
  final Color primaryColor99;
  final Color primaryColor100;

  //secondary colors
  final Color secondaryColor0;
  final Color secondaryColor10;
  final Color secondaryColor20;
  final Color secondaryColor30;
  final Color secondaryColor40;
  final Color secondaryColor50;
  final Color secondaryColor60;
  final Color secondaryColor70;
  final Color secondaryColor80;
  final Color secondaryColor90;
  final Color secondaryColor95;
  final Color secondaryColor99;
  final Color secondaryColor100;

  //success colors
  final Color successColor0;
  final Color successColor10;
  final Color successColor20;
  final Color successColor30;
  final Color successColor40;
  final Color successColor50;
  final Color successColor60;
  final Color successColor70;
  final Color successColor80;
  final Color successColor90;
  final Color successColor95;
  final Color successColor99;
  final Color successColor100;

  //error colors
  final Color errorColor0;
  final Color errorColor10;
  final Color errorColor20;
  final Color errorColor30;
  final Color errorColor40;
  final Color errorColor50;
  final Color errorColor60;
  final Color errorColor70;
  final Color errorColor80;
  final Color errorColor90;
  final Color errorColor95;
  final Color errorColor99;
  final Color errorColor100;

  //neutral colors
  final Color neutralColor0;
  final Color neutralColor10;
  final Color neutralColor20;
  final Color neutralColor30;
  final Color neutralColor40;
  final Color neutralColor50;
  final Color neutralColor60;
  final Color neutralColor70;
  final Color neutralColor80;
  final Color neutralColor95;
  final Color neutralColor90;
  final Color neutralColor99;
  final Color neutralColor100;

  //background color
  final Color backgroundColor;

  @override
  ThemeExtension<AppColors> copyWith({
    final Color? primaryColor0,
    final Color? primaryColor10,
    final Color? primaryColor20,
    final Color? primaryColor30,
    final Color? primaryColor40,
    final Color? primaryColor50,
    final Color? primaryColor60,
    final Color? primaryColor70,
    final Color? primaryColor80,
    final Color? primaryColor90,
    final Color? primaryColor95,
    final Color? primaryColor99,
    final Color? primaryColor100,
    final Color? secondaryColor0,
    final Color? secondaryColor10,
    final Color? secondaryColor20,
    final Color? secondaryColor30,
    final Color? secondaryColor40,
    final Color? secondaryColor50,
    final Color? secondaryColor60,
    final Color? secondaryColor70,
    final Color? secondaryColor80,
    final Color? secondaryColor90,
    final Color? secondaryColor95,
    final Color? secondaryColor99,
    final Color? secondaryColor100,
    final Color? successColor0,
    final Color? successColor10,
    final Color? successColor20,
    final Color? successColor30,
    final Color? successColor40,
    final Color? successColor50,
    final Color? successColor60,
    final Color? successColor70,
    final Color? successColor80,
    final Color? successColor90,
    final Color? successColor95,
    final Color? successColor99,
    final Color? successColor100,
    final Color? errorColor0,
    final Color? errorColor10,
    final Color? errorColor20,
    final Color? errorColor30,
    final Color? errorColor40,
    final Color? errorColor50,
    final Color? errorColor60,
    final Color? errorColor70,
    final Color? errorColor80,
    final Color? errorColor90,
    final Color? errorColor95,
    final Color? errorColor99,
    final Color? errorColor100,
    final Color? neutralColor0,
    final Color? neutralColor10,
    final Color? neutralColor20,
    final Color? neutralColor30,
    final Color? neutralColor40,
    final Color? neutralColor50,
    final Color? neutralColor60,
    final Color? neutralColor70,
    final Color? neutralColor80,
    final Color? neutralColor90,
    final Color? neutralColor95,
    final Color? neutralColor99,
    final Color? neutralColor100,
    final Color? backgroundColor,
  }) {
    return AppColors(
      primaryColor0: primaryColor0 ?? this.primaryColor0,
      primaryColor10: primaryColor10 ?? this.primaryColor10,
      primaryColor20: primaryColor20 ?? this.primaryColor20,
      primaryColor30: primaryColor30 ?? this.primaryColor30,
      primaryColor40: primaryColor40 ?? this.primaryColor40,
      primaryColor50: primaryColor50 ?? this.primaryColor50,
      primaryColor60: primaryColor60 ?? this.primaryColor60,
      primaryColor70: primaryColor70 ?? this.primaryColor70,
      primaryColor80: primaryColor80 ?? this.primaryColor80,
      primaryColor90: primaryColor90 ?? this.primaryColor90,
      primaryColor95: primaryColor95 ?? this.primaryColor95,
      primaryColor99: primaryColor99 ?? this.primaryColor99,
      primaryColor100: primaryColor100 ?? this.primaryColor100,
      secondaryColor0: secondaryColor0 ?? this.secondaryColor0,
      secondaryColor10: secondaryColor10 ?? this.secondaryColor10,
      secondaryColor20: secondaryColor20 ?? this.secondaryColor20,
      secondaryColor30: secondaryColor30 ?? this.secondaryColor30,
      secondaryColor40: secondaryColor40 ?? this.secondaryColor40,
      secondaryColor50: secondaryColor50 ?? this.secondaryColor50,
      secondaryColor60: secondaryColor60 ?? this.secondaryColor60,
      secondaryColor70: secondaryColor70 ?? this.secondaryColor70,
      secondaryColor80: secondaryColor80 ?? this.secondaryColor80,
      secondaryColor90: secondaryColor90 ?? this.secondaryColor90,
      secondaryColor95: secondaryColor95 ?? this.secondaryColor95,
      secondaryColor99: secondaryColor99 ?? this.secondaryColor99,
      secondaryColor100: secondaryColor100 ?? this.secondaryColor100,
      successColor0: successColor0 ?? this.successColor0,
      successColor10: successColor10 ?? this.successColor10,
      successColor20: successColor20 ?? this.successColor20,
      successColor30: successColor30 ?? this.successColor30,
      successColor40: successColor40 ?? this.successColor40,
      successColor50: successColor50 ?? this.successColor50,
      successColor60: successColor60 ?? this.successColor60,
      successColor70: successColor70 ?? this.successColor70,
      successColor80: successColor80 ?? this.successColor80,
      successColor90: successColor90 ?? this.successColor90,
      successColor95: successColor95 ?? this.successColor95,
      successColor99: successColor99 ?? this.successColor99,
      successColor100: successColor100 ?? this.successColor100,
      errorColor0: errorColor0 ?? this.errorColor0,
      errorColor10: errorColor10 ?? this.errorColor10,
      errorColor20: errorColor20 ?? this.errorColor20,
      errorColor30: errorColor30 ?? this.errorColor30,
      errorColor40: errorColor40 ?? this.errorColor40,
      errorColor50: errorColor50 ?? this.errorColor50,
      errorColor60: errorColor60 ?? this.errorColor60,
      errorColor70: errorColor70 ?? this.errorColor70,
      errorColor80: errorColor80 ?? this.errorColor80,
      errorColor90: errorColor90 ?? this.errorColor90,
      errorColor95: errorColor95 ?? this.errorColor95,
      errorColor99: errorColor99 ?? this.errorColor99,
      errorColor100: errorColor100 ?? this.errorColor100,
      neutralColor0: neutralColor0 ?? this.neutralColor0,
      neutralColor10: neutralColor10 ?? this.neutralColor10,
      neutralColor20: neutralColor20 ?? this.neutralColor20,
      neutralColor30: neutralColor30 ?? this.neutralColor30,
      neutralColor40: neutralColor40 ?? this.neutralColor40,
      neutralColor50: neutralColor50 ?? this.neutralColor50,
      neutralColor60: neutralColor60 ?? this.neutralColor60,
      neutralColor70: neutralColor70 ?? this.neutralColor70,
      neutralColor80: neutralColor80 ?? this.neutralColor80,
      neutralColor90: neutralColor90 ?? this.neutralColor90,
      neutralColor95: neutralColor95 ?? this.neutralColor95,
      neutralColor99: neutralColor99 ?? this.neutralColor99,
      neutralColor100: neutralColor100 ?? this.neutralColor100,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primaryColor0: Color.lerp(primaryColor0, other.primaryColor0, t)!,
      primaryColor10: Color.lerp(primaryColor10, other.primaryColor10, t)!,
      primaryColor20: Color.lerp(primaryColor20, other.primaryColor20, t)!,
      primaryColor30: Color.lerp(primaryColor30, other.primaryColor30, t)!,
      primaryColor40: Color.lerp(primaryColor40, other.primaryColor40, t)!,
      primaryColor50: Color.lerp(primaryColor50, other.primaryColor50, t)!,
      primaryColor60: Color.lerp(primaryColor60, other.primaryColor60, t)!,
      primaryColor70: Color.lerp(primaryColor70, other.primaryColor70, t)!,
      primaryColor80: Color.lerp(primaryColor80, other.primaryColor80, t)!,
      primaryColor90: Color.lerp(primaryColor90, other.primaryColor90, t)!,
      primaryColor95: Color.lerp(primaryColor95, other.primaryColor95, t)!,
      primaryColor99: Color.lerp(primaryColor99, other.primaryColor99, t)!,
      primaryColor100: Color.lerp(primaryColor100, other.primaryColor100, t)!,
      secondaryColor0: Color.lerp(secondaryColor0, other.secondaryColor0, t)!,
      secondaryColor10: Color.lerp(secondaryColor10, other.secondaryColor10, t)!,
      secondaryColor20: Color.lerp(secondaryColor20, other.secondaryColor20, t)!,
      secondaryColor30: Color.lerp(secondaryColor30, other.secondaryColor30, t)!,
      secondaryColor40: Color.lerp(secondaryColor40, other.secondaryColor40, t)!,
      secondaryColor50: Color.lerp(secondaryColor50, other.secondaryColor50, t)!,
      secondaryColor60: Color.lerp(secondaryColor60, other.secondaryColor60, t)!,
      secondaryColor70: Color.lerp(secondaryColor70, other.secondaryColor70, t)!,
      secondaryColor80: Color.lerp(secondaryColor80, other.secondaryColor80, t)!,
      secondaryColor90: Color.lerp(secondaryColor90, other.secondaryColor90, t)!,
      secondaryColor95: Color.lerp(secondaryColor95, other.secondaryColor95, t)!,
      secondaryColor99: Color.lerp(secondaryColor99, other.secondaryColor99, t)!,
      secondaryColor100: Color.lerp(secondaryColor100, other.secondaryColor100, t)!,
      successColor0: Color.lerp(successColor0, other.successColor0, t)!,
      successColor10: Color.lerp(successColor10, other.successColor10, t)!,
      successColor20: Color.lerp(successColor20, other.successColor20, t)!,
      successColor30: Color.lerp(successColor30, other.successColor30, t)!,
      successColor40: Color.lerp(successColor40, other.successColor40, t)!,
      successColor50: Color.lerp(successColor50, other.successColor50, t)!,
      successColor60: Color.lerp(successColor60, other.successColor60, t)!,
      successColor70: Color.lerp(successColor70, other.successColor70, t)!,
      successColor80: Color.lerp(successColor80, other.successColor80, t)!,
      successColor90: Color.lerp(successColor90, other.successColor90, t)!,
      successColor95: Color.lerp(successColor95, other.successColor95, t)!,
      successColor99: Color.lerp(successColor99, other.successColor100, t)!,
      successColor100: Color.lerp(successColor100, other.successColor100, t)!,
      errorColor0: Color.lerp(errorColor0, other.errorColor0, t)!,
      errorColor10: Color.lerp(errorColor10, other.errorColor10, t)!,
      errorColor20: Color.lerp(errorColor20, other.errorColor20, t)!,
      errorColor30: Color.lerp(errorColor30, other.errorColor30, t)!,
      errorColor40: Color.lerp(errorColor40, other.errorColor40, t)!,
      errorColor50: Color.lerp(errorColor50, other.errorColor50, t)!,
      errorColor60: Color.lerp(errorColor60, other.errorColor60, t)!,
      errorColor70: Color.lerp(errorColor70, other.errorColor70, t)!,
      errorColor80: Color.lerp(errorColor80, other.errorColor80, t)!,
      errorColor90: Color.lerp(errorColor90, other.errorColor90, t)!,
      errorColor95: Color.lerp(errorColor95, other.errorColor95, t)!,
      errorColor99: Color.lerp(errorColor99, other.errorColor99, t)!,
      errorColor100: Color.lerp(errorColor100, other.errorColor100, t)!,
      neutralColor0: Color.lerp(neutralColor0, other.neutralColor0, t)!,
      neutralColor10: Color.lerp(neutralColor10, other.neutralColor10, t)!,
      neutralColor20: Color.lerp(neutralColor20, other.neutralColor20, t)!,
      neutralColor30: Color.lerp(neutralColor30, other.neutralColor30, t)!,
      neutralColor40: Color.lerp(neutralColor40, other.neutralColor40, t)!,
      neutralColor50: Color.lerp(neutralColor50, other.neutralColor50, t)!,
      neutralColor60: Color.lerp(neutralColor60, other.neutralColor60, t)!,
      neutralColor70: Color.lerp(neutralColor70, other.neutralColor70, t)!,
      neutralColor80: Color.lerp(neutralColor80, other.neutralColor80, t)!,
      neutralColor90: Color.lerp(neutralColor90, other.neutralColor90, t)!,
      neutralColor95: Color.lerp(neutralColor95, other.neutralColor95, t)!,
      neutralColor99: Color.lerp(neutralColor99, other.neutralColor99, t)!,
      neutralColor100: Color.lerp(neutralColor100, other.neutralColor100, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }
}

@protected
class AppLightColors extends AppColors {
  AppLightColors(
      {super.primaryColor0 = const Color(0xFF000000),
      super.primaryColor10 = const Color(0xFF053973),
      super.primaryColor20 = const Color(0xFF064388),
      super.primaryColor30 = const Color(0xFF064A96),
      super.primaryColor40 = const Color(0xFF014FA7),
      super.primaryColor50 = const Color(0xFF005ABF),
      super.primaryColor60 = const Color(0xFF2B75CC),
      super.primaryColor70 = const Color(0xFF5B96DB),
      super.primaryColor80 = const Color(0xFF8BB8EC),
      super.primaryColor90 = const Color(0xFFAED0F5),
      super.primaryColor95 = const Color(0xFFD2E5FA),
      super.primaryColor99 = const Color(0xFFE4EFFB),
      super.primaryColor100 = const Color(0xFFFFFFFF),
      super.backgroundColor = const Color(0xFFF7F5FF),
      super.errorColor0 = const Color(0xFF000000),
      super.errorColor10 = const Color(0xFF750606),
      super.errorColor20 = const Color(0xFF940707),
      super.errorColor30 = const Color(0xFFBB0707),
      super.errorColor40 = const Color(0xFFD60A0A),
      super.errorColor50 = const Color(0xFFEA0A0A),
      super.errorColor60 = const Color(0xFFFF5449),
      super.errorColor70 = const Color(0xFFFF897D),
      super.errorColor80 = const Color(0xFFFFB4AB),
      super.errorColor90 = const Color(0xFFFFDAD6),
      super.errorColor95 = const Color(0xFFFFEDEA),
      super.errorColor99 = const Color(0xFFFFFBFF),
      super.errorColor100 = const Color(0xFFFFFFFF),
      super.neutralColor0 = const Color(0xFF000000),
      super.neutralColor10 = const Color(0xFF000000),
      super.neutralColor20 = const Color(0xFF2F3033),
      super.neutralColor30 = const Color(0xFF2F3033),
      super.neutralColor40 = const Color(0xFF5E5E62),
      super.neutralColor50 = const Color(0xFF76777A),
      super.neutralColor60 = const Color(0xFF909094),
      super.neutralColor70 = const Color(0xFFABABAF),
      super.neutralColor80 = const Color(0xFFC7C6CA),
      super.neutralColor90 = const Color(0xFFE3E2E6),
      super.neutralColor95 = const Color(0xFFF1F0F4),
      super.neutralColor99 = const Color(0xFFFDFBFF),
      super.neutralColor100 = const Color(0xFFFFFFFF),
      super.secondaryColor0 = const Color(0xFF000000),
      super.secondaryColor10 = const Color(0xFF705F07),
      super.secondaryColor20 = const Color(0xFFB49807),
      super.secondaryColor30 = const Color(0xFFC9AA08),
      super.secondaryColor40 = const Color(0xFFE5C208),
      super.secondaryColor50 = const Color(0xFFF8D004),
      super.secondaryColor60 = const Color(0xFFF8D004),
      super.secondaryColor70 = const Color(0xFFFFDB20),
      super.secondaryColor80 = const Color(0xFFFFE03E),
      super.secondaryColor90 = const Color(0xFFFFE76A),
      super.secondaryColor95 = const Color(0xFFFFF0A1),
      super.secondaryColor99 = const Color(0xFFFFF7CC),
      super.secondaryColor100 = const Color(0xFFFFFFFF),
      super.successColor0 = const Color(0xFF000000),
      super.successColor10 = const Color(0xFF002202),
      super.successColor20 = const Color(0xFF003A06),
      super.successColor30 = const Color(0xFF00530C),
      super.successColor40 = const Color(0xFF006E13),
      super.successColor50 = const Color(0xFF008B1B),
      super.successColor60 = const Color(0xFF23B131),
      super.successColor70 = const Color(0xFF36C43D),
      super.successColor80 = const Color(0xFF57E156),
      super.successColor90 = const Color(0xFFB8F1AC),
      super.successColor95 = const Color(0xFFC9FFBD),
      super.successColor99 = const Color(0xFFF6FFEF),
      super.successColor100 = const Color(0xFFFFFFFF)});
}
