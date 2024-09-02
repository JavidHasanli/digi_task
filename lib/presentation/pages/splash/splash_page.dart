import 'package:digi_task/core/constants/path/image_paths.dart';
import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/core/utility/extension/image_path_ext.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primaryColor60,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90),
              child: Image.asset(ImagePath.logo.toPathPng),
            ),
            const SizedBox(height: 24),
            Text(
              "Digi Task",
              style: context.typography.h4Medium.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
