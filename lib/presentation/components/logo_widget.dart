import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/core/utility/extension/image_path_ext.dart';
import 'package:flutter/material.dart';

import '../../core/constants/path/image_paths.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
    required this.height,
    required this.width,
  });
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.primaryColor60,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 22),
        child: Image.asset(
          ImagePath.logo.toPathPng,
          height: height,
          width: width,
        ),
      ),
    );
  }
}
