import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:flutter/material.dart';

class ComponentTitle extends StatelessWidget {
  const ComponentTitle({
    super.key,
    required this.title,
    required this.onPressed,
  });
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: context.typography.subtitle2Medium,
          ),
          const Icon(Icons.arrow_forward_ios_rounded)
        ],
      ),
    );
  }
}
