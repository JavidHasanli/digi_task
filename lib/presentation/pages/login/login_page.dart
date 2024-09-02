import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/notifier/auth/login/login_notifier.dart';
import 'package:digi_task/presentation/components/button/login_button.dart';
import 'package:digi_task/presentation/components/input/custom_form_filed.dart';
import 'package:digi_task/presentation/components/logo_widget.dart';
import 'package:digi_task/presentation/pages/login/view/reset_password_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../notifier/auth/auth_notifier.dart';
import '../../../notifier/auth/login/login_state.dart';
import '../../components/flushbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  late LoginNotifier _loginNotifier;

  @override
  void initState() {
    super.initState();

    _loginNotifier = context.read<LoginNotifier>();

    _loginNotifier.addListener(
      () {
        final loginState = _loginNotifier.state;

        if (loginState is LoginSuccess) {
          context.read<AuthNotifier>().userLogged();
        } else if (loginState is LoginFailure) {
          openFlushbar(context, message: loginState.message, title: "İstifadəçi tapılmadı", color: Colors.transparent);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.neutralColor100,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const LogoWidget(height: 116, width: 134),
              const SizedBox(
                height: 24,
              ),
              CustomFormField(
                controller: emailController,
                title: 'Mail adresiniz',
                hintText: "Mail adresiniz",
                icon: Icons.mail_outline,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomFormField(
                controller: passwordController,
                title: 'Şifrəniz',
                hintText: "*****",
                icon: Icons.key_outlined,
              ),
              const Spacer(),
              Consumer<LoginNotifier>(
                builder: (context, notifier, child) {
                  return ActionButton(
                    isLoading: (notifier.state is LoginProgress) ? true : false,
                    onPressed: () {
                      FocusManager.instance.primaryFocus!.unfocus();
                      notifier.loginUser(email: emailController.text, password: passwordController.text);
                    },
                  );
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const ResetPassword();
                    },
                  ));
                },
                child: Text(
                  "Şifrəni unutmusunuz?",
                  style: context.typography.body2Regular.copyWith(
                      color: context.colors.primaryColor50,
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                      decorationColor: context.colors.primaryColor50),
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
