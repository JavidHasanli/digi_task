import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/presentation/components/button/login_button.dart';
import 'package:digi_task/presentation/components/input/custom_form_filed.dart';
import 'package:digi_task/presentation/pages/login/view/send_code_view.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.neutralColor100,
      appBar: AppBar(
        backgroundColor: context.colors.neutralColor100,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_rounded)),
        centerTitle: true,
        title: Text(
          'Şifrəni yenilə',
          style: context.typography.subtitle1Medium.copyWith(color: context.colors.neutralColor10),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Mail adresinizi daxil edin.',
                style: context.typography.subtitle2Medium.copyWith(color: context.colors.neutralColor40),
              ),
              const SizedBox(height: 24),
              CustomFormField(
                  controller: emailController,
                  title: 'Mail adresiniz',
                  icon: Icons.mail_outline,
                  hintText: 'Mail adresiniz'),
              const SizedBox(height: 80),
              ActionButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return SendCodeView(
                        emailAdress: emailController.text,
                      );
                    },
                  ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
