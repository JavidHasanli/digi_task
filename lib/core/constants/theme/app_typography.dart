import 'package:flutter/material.dart';

interface class AppTypography extends ThemeExtension<AppTypography> {
  AppTypography({
    required this.h1Light,
    required this.h2Light,
    required this.h3Light,
    required this.h4Light,
    required this.h5Light,
    required this.h6Light,
    required this.subtitle1Light,
    required this.subtitle2Light,
    required this.body1Light,
    required this.body2Light,
    required this.captionLight,
    required this.overlineLight,
    required this.h1Regular,
    required this.h2Regular,
    required this.h3Regular,
    required this.h4Regular,
    required this.h5Regular,
    required this.h6Regular,
    required this.subtitle1Regular,
    required this.subtitle2Regular,
    required this.body1Regular,
    required this.body2Regular,
    required this.captionRegular,
    required this.overlineRegular,
    required this.h1Medium,
    required this.h2Medium,
    required this.h3Medium,
    required this.h4Medium,
    required this.h5Medium,
    required this.h6Medium,
    required this.subtitle1Medium,
    required this.subtitle2Medium,
    required this.body1Medium,
    required this.body2Medium,
    required this.captionMedium,
    required this.overlineMedium,
    required this.h1SemiBold,
    required this.h2SemiBold,
    required this.h3SemiBold,
    required this.h4SemiBold,
    required this.h5SemiBold,
    required this.h6SemiBold,
    required this.subtitle1SemiBold,
    required this.subtitle2SemiBold,
    required this.body1SemiBold,
    required this.body2SemiBold,
    required this.captionSemiBold,
    required this.overlineSemiBold,
  });
  // Light
  final TextStyle h1Light;
  final TextStyle h2Light;
  final TextStyle h3Light;
  final TextStyle h4Light;
  final TextStyle h5Light;
  final TextStyle h6Light;
  final TextStyle subtitle1Light;
  final TextStyle subtitle2Light;
  final TextStyle body1Light;
  final TextStyle body2Light;
  final TextStyle captionLight;
  final TextStyle overlineLight;

  // Regular
  final TextStyle h1Regular;
  final TextStyle h2Regular;
  final TextStyle h3Regular;
  final TextStyle h4Regular;
  final TextStyle h5Regular;
  final TextStyle h6Regular;
  final TextStyle subtitle1Regular;
  final TextStyle subtitle2Regular;
  final TextStyle body1Regular;
  final TextStyle body2Regular;
  final TextStyle captionRegular;
  final TextStyle overlineRegular;

  // Medium
  final TextStyle h1Medium;
  final TextStyle h2Medium;
  final TextStyle h3Medium;
  final TextStyle h4Medium;
  final TextStyle h5Medium;
  final TextStyle h6Medium;
  final TextStyle subtitle1Medium;
  final TextStyle subtitle2Medium;
  final TextStyle body1Medium;
  final TextStyle body2Medium;
  final TextStyle captionMedium;
  final TextStyle overlineMedium;

  // SemiBold
  final TextStyle h1SemiBold;
  final TextStyle h2SemiBold;
  final TextStyle h3SemiBold;
  final TextStyle h4SemiBold;
  final TextStyle h5SemiBold;
  final TextStyle h6SemiBold;
  final TextStyle subtitle1SemiBold;
  final TextStyle subtitle2SemiBold;
  final TextStyle body1SemiBold;
  final TextStyle body2SemiBold;
  final TextStyle captionSemiBold;
  final TextStyle overlineSemiBold;

  @override
  ThemeExtension<AppTypography> copyWith({
    final TextStyle? h1Light,
    final TextStyle? h2Light,
    final TextStyle? h3Light,
    final TextStyle? h4Light,
    final TextStyle? h5Light,
    final TextStyle? h6Light,
    final TextStyle? subtitle1Light,
    final TextStyle? subtitle2Light,
    final TextStyle? body1Light,
    final TextStyle? body2Light,
    final TextStyle? captionLight,
    final TextStyle? overlineLight,
    final TextStyle? h1Regular,
    final TextStyle? h2Regular,
    final TextStyle? h3Regular,
    final TextStyle? h4Regular,
    final TextStyle? h5Regular,
    final TextStyle? h6Regular,
    final TextStyle? subtitle1Regular,
    final TextStyle? subtitle2Regular,
    final TextStyle? body1Regular,
    final TextStyle? body2Regular,
    final TextStyle? captionRegular,
    final TextStyle? overlineRegular,
    final TextStyle? h1Medium,
    final TextStyle? h2Medium,
    final TextStyle? h3Medium,
    final TextStyle? h4Medium,
    final TextStyle? h5Medium,
    final TextStyle? h6Medium,
    final TextStyle? subtitle1Medium,
    final TextStyle? subtitle2Medium,
    final TextStyle? body1Medium,
    final TextStyle? body2Medium,
    final TextStyle? captionMedium,
    final TextStyle? overlineMedium,
    final TextStyle? h1SemiBold,
    final TextStyle? h2SemiBold,
    final TextStyle? h3SemiBold,
    final TextStyle? h4SemiBold,
    final TextStyle? h5SemiBold,
    final TextStyle? h6SemiBold,
    final TextStyle? subtitle1SemiBold,
    final TextStyle? subtitle2SemiBold,
    final TextStyle? body1SemiBold,
    final TextStyle? body2SemiBold,
    final TextStyle? captionSemiBold,
    final TextStyle? overlineSemiBold,
  }) {
    return AppTypography(
      h1Light: h1Light ?? this.h1Light,
      h2Light: h2Light ?? this.h2Light,
      h3Light: h3Light ?? this.h3Light,
      h4Light: h4Light ?? this.h4Light,
      h5Light: h5Light ?? this.h5Light,
      h6Light: h6Light ?? this.h6Light,
      subtitle1Light: subtitle1Light ?? this.subtitle1Light,
      subtitle2Light: subtitle2Light ?? this.subtitle2Light,
      body1Light: body1Light ?? this.body1Light,
      body2Light: body2Light ?? this.body2Light,
      captionLight: captionLight ?? this.captionLight,
      overlineLight: overlineLight ?? this.overlineLight,
      h1Regular: h1Regular ?? this.h1Regular,
      h2Regular: h2Regular ?? this.h2Regular,
      h3Regular: h3Regular ?? this.h3Regular,
      h4Regular: h4Regular ?? this.h4Regular,
      h5Regular: h5Regular ?? this.h5Regular,
      h6Regular: h6Regular ?? this.h6Regular,
      subtitle1Regular: subtitle1Regular ?? this.subtitle1Regular,
      subtitle2Regular: subtitle2Regular ?? this.subtitle2Regular,
      body1Regular: body1Regular ?? this.body1Regular,
      body2Regular: body2Regular ?? this.body2Regular,
      captionRegular: captionRegular ?? this.captionRegular,
      overlineRegular: overlineRegular ?? this.overlineRegular,
      h1Medium: h1Medium ?? this.h1Medium,
      h2Medium: h2Medium ?? this.h2Medium,
      h3Medium: h3Medium ?? this.h3Medium,
      h4Medium: h4Medium ?? this.h4Medium,
      h5Medium: h5Medium ?? this.h5Medium,
      h6Medium: h6Medium ?? this.h6Medium,
      subtitle1Medium: subtitle1Medium ?? this.subtitle1Medium,
      subtitle2Medium: subtitle2Medium ?? this.subtitle2Medium,
      body1Medium: body1Medium ?? this.body1Medium,
      body2Medium: body2Medium ?? this.body2Medium,
      captionMedium: captionMedium ?? this.captionMedium,
      overlineMedium: overlineMedium ?? this.overlineMedium,
      h1SemiBold: h1SemiBold ?? this.h1SemiBold,
      h2SemiBold: h2SemiBold ?? this.h2SemiBold,
      h3SemiBold: h3SemiBold ?? this.h3SemiBold,
      h4SemiBold: h4SemiBold ?? this.h4SemiBold,
      h5SemiBold: h5SemiBold ?? this.h5SemiBold,
      h6SemiBold: h6SemiBold ?? this.h6SemiBold,
      subtitle1SemiBold: subtitle1SemiBold ?? this.subtitle1SemiBold,
      subtitle2SemiBold: subtitle2SemiBold ?? this.subtitle2SemiBold,
      body1SemiBold: body1SemiBold ?? this.body1SemiBold,
      body2SemiBold: body2SemiBold ?? this.body2SemiBold,
      captionSemiBold: captionSemiBold ?? this.captionSemiBold,
      overlineSemiBold: overlineSemiBold ?? this.overlineSemiBold,
    );
  }

  @override
  ThemeExtension<AppTypography> lerp(covariant ThemeExtension<AppTypography>? other, double t) {
    if (other is! AppTypography) {
      return this;
    }
    return AppTypography(
      h1Light: TextStyle.lerp(h1Light, other.h1Light, t)!,
      h2Light: TextStyle.lerp(h2Light, other.h2Light, t)!,
      h3Light: TextStyle.lerp(h3Light, other.h3Light, t)!,
      h4Light: TextStyle.lerp(h4Light, other.h4Light, t)!,
      h5Light: TextStyle.lerp(h5Light, other.h5Light, t)!,
      h6Light: TextStyle.lerp(h6Light, other.h6Light, t)!,
      subtitle1Light: TextStyle.lerp(subtitle1Light, other.subtitle1Light, t)!,
      subtitle2Light: TextStyle.lerp(subtitle2Light, other.subtitle2Light, t)!,
      body1Light: TextStyle.lerp(body1Light, other.body1Light, t)!,
      body2Light: TextStyle.lerp(body2Light, other.body2Light, t)!,
      captionLight: TextStyle.lerp(captionLight, other.captionLight, t)!,
      overlineLight: TextStyle.lerp(overlineLight, other.overlineLight, t)!,
      h1Regular: TextStyle.lerp(h1Regular, other.h1Regular, t)!,
      h2Regular: TextStyle.lerp(h2Regular, other.h2Regular, t)!,
      h3Regular: TextStyle.lerp(h3Regular, other.h3Regular, t)!,
      h4Regular: TextStyle.lerp(h4Regular, other.h4Regular, t)!,
      h5Regular: TextStyle.lerp(h5Regular, other.h5Regular, t)!,
      h6Regular: TextStyle.lerp(h6Regular, other.h6Regular, t)!,
      subtitle1Regular: TextStyle.lerp(subtitle1Regular, other.subtitle1Regular, t)!,
      subtitle2Regular: TextStyle.lerp(subtitle2Regular, other.subtitle2Regular, t)!,
      body1Regular: TextStyle.lerp(body1Regular, other.body1Regular, t)!,
      body2Regular: TextStyle.lerp(body2Regular, other.body2Regular, t)!,
      captionRegular: TextStyle.lerp(captionRegular, other.captionRegular, t)!,
      overlineRegular: TextStyle.lerp(overlineRegular, other.overlineRegular, t)!,
      h1Medium: TextStyle.lerp(h1Medium, other.h1Medium, t)!,
      h2Medium: TextStyle.lerp(h2Medium, other.h2Medium, t)!,
      h3Medium: TextStyle.lerp(h3Medium, other.h3Medium, t)!,
      h4Medium: TextStyle.lerp(h4Medium, other.h4Medium, t)!,
      h5Medium: TextStyle.lerp(h5Medium, other.h5Medium, t)!,
      h6Medium: TextStyle.lerp(h6Medium, other.h6Medium, t)!,
      subtitle1Medium: TextStyle.lerp(subtitle1Medium, other.subtitle1Medium, t)!,
      subtitle2Medium: TextStyle.lerp(subtitle2Medium, other.subtitle2Medium, t)!,
      body1Medium: TextStyle.lerp(body1Medium, other.body1Medium, t)!,
      body2Medium: TextStyle.lerp(body2Medium, other.body2Medium, t)!,
      captionMedium: TextStyle.lerp(captionMedium, other.captionMedium, t)!,
      overlineMedium: TextStyle.lerp(overlineMedium, other.overlineMedium, t)!,
      h1SemiBold: TextStyle.lerp(h1SemiBold, other.h1SemiBold, t)!,
      h2SemiBold: TextStyle.lerp(h2SemiBold, other.h2SemiBold, t)!,
      h3SemiBold: TextStyle.lerp(h3SemiBold, other.h3SemiBold, t)!,
      h4SemiBold: TextStyle.lerp(h4SemiBold, other.h4SemiBold, t)!,
      h5SemiBold: TextStyle.lerp(h5SemiBold, other.h5SemiBold, t)!,
      h6SemiBold: TextStyle.lerp(h6SemiBold, other.h6SemiBold, t)!,
      subtitle1SemiBold: TextStyle.lerp(subtitle1SemiBold, other.subtitle1SemiBold, t)!,
      subtitle2SemiBold: TextStyle.lerp(subtitle2SemiBold, other.subtitle2SemiBold, t)!,
      body1SemiBold: TextStyle.lerp(body1SemiBold, other.body1SemiBold, t)!,
      body2SemiBold: TextStyle.lerp(body2SemiBold, other.body2SemiBold, t)!,
      captionSemiBold: TextStyle.lerp(captionSemiBold, other.captionSemiBold, t)!,
      overlineSemiBold: TextStyle.lerp(overlineSemiBold, other.overlineSemiBold, t)!,
    );
  }
}
