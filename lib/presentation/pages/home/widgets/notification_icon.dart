import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarIcon extends StatelessWidget {
  final String iconPath;
  final VoidCallback onTap;
  final int notificationNumber; 

  const AppBarIcon({
    super.key,
    required this.iconPath,
    required this.onTap,
    this.notificationNumber = 0, 
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: onTap,
          icon: SvgPicture.asset(iconPath),
        ),
        if (notificationNumber > 0)
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                '$notificationNumber',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
