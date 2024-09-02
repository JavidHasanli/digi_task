import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

extension ThemeExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  AppColors get colors => theme.extension<AppColors>()!;
  AppTypography get typography => theme.extension<AppTypography>()!;
}
