import 'package:digi_task/core/constants/routes.dart';
import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../components/button/login_button.dart';
import '../../components/logo_widget.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: context.colors.neutralColor100,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              const LogoWidget(
                height: 140,
                width: 150,
              ),
              const SizedBox(
                height: 24,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Digi Task',
                      style: context.typography.subtitle1SemiBold.copyWith(color: context.colors.primaryColor60),
                    ),
                    TextSpan(text: 'a xoş gəlmisiniz', style: context.typography.subtitle1SemiBold),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Center(
                child: Text(
                  appLocalizations.onboarddingSubtitle,
                  textAlign: TextAlign.center,
                  style: context.typography.body1Regular.copyWith(color: context.colors.neutralColor50),
                ),
              ),
              const Spacer(),
              ActionButton(
                onPressed: () {
                  context.goNamed(AppRoutes.login.name);
                },
              ),
              const SizedBox(
                height: 72,
              )
            ],
          ),
        ),
      ),
    );
  }
}
