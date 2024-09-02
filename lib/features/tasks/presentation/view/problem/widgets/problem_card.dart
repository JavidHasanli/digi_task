import 'package:flutter/material.dart';

class CardWithTitleAndIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;

  const CardWithTitleAndIcon({
    Key? key,
    required this.title,
    required this.icon,
    this.iconColor = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          Icon(
            icon,
            color: iconColor,
          ),
        ],
      ),
    );
  }
}
