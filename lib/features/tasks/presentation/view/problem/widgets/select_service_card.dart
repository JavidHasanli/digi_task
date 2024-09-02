import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectServiceCard extends StatefulWidget {
  const SelectServiceCard(
      {super.key, required this.image, required this.title, required this.onTap, required this.isSelected});
  final String image;
  final String title;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  State<SelectServiceCard> createState() => _SelectServiceCardState();
}

class _SelectServiceCardState extends State<SelectServiceCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 4.0),
        child: Container(
          decoration: BoxDecoration(
            color: widget.isSelected ? context.colors.secondaryColor60 : context.colors.neutralColor100,
            borderRadius: BorderRadius.circular(12),
            border:
                Border.all(color: context.colors.secondaryColor60, strokeAlign: BorderSide.strokeAlignCenter, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  widget.image,
                  height: 16,
                  width: 16,
                  color: context.colors.neutralColor40,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  widget.title,
                  style: context.typography.overlineSemiBold.copyWith(color: context.colors.neutralColor40),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
