import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServiceType extends StatelessWidget {
  const ServiceType({
    super.key,
    required this.image,
    required this.title,
  });
  final String image;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: Container(
        decoration: BoxDecoration(color: context.colors.secondaryColor60, borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SvgPicture.asset(
                image,
                height: 16,
                width: 16,
                color: context.colors.neutralColor40,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                title,
                style: context.typography.overlineSemiBold.copyWith(color: context.colors.neutralColor40),
              )
            ],
          ),
        ),
      ),
    );
  }
}
