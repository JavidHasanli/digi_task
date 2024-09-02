import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final IconData? icon;
  final bool isServisField;
  final bool isAdmin;
  final String serviceType;
  final void Function(BuildContext context, TextEditingController controller)? onTap;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.title,
    this.icon,
    required this.isServisField,
    required this.isAdmin,
    required this.serviceType,
    this.onTap,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          labelText: title,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            textBaseline: TextBaseline.alphabetic,
          ),
          prefixIcon: icon != null
              ? Icon(
                  icon,
                  color: Colors.blue,
                )
              : null,
          suffixIcon: isServisField
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      serviceType,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                )
              : null,
        ),
        onTap: () {
          if (title == 'Saat' && onTap != null) {
            onTap!(context, controller);
          }
        },
        readOnly: !isAdmin || isServisField,
        validator: title == 'Tarix' ? validator : null,
      ),
    );
  }
}
