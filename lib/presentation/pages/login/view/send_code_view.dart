import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/presentation/components/button/login_button.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class SendCodeView extends StatelessWidget {
  const SendCodeView({super.key, required this.emailAdress});
  final String? emailAdress;

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
          'Kodu daxil et',
          style: context.typography.subtitle1Medium.copyWith(color: context.colors.neutralColor10),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: emailAdress,
                      style: context.typography.body2Regular.copyWith(color: context.colors.primaryColor50),
                    ),
                    TextSpan(
                      text: " adresinə göndərdiyimiz 4 rəqəmli kodu daxil edin",
                      style: context.typography.body2Regular.copyWith(color: context.colors.neutralColor40),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Pinput(
                defaultPinTheme: PinTheme(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: context.colors.backgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: context.typography.h3Medium.copyWith(
                    color: context.colors.primaryColor50,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Kod gəlmədi? ",
                    style: context.typography.body1Regular.copyWith(color: context.colors.neutralColor40),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Təkrar göndər',
                      style: context.typography.body1SemiBold.copyWith(color: context.colors.primaryColor50),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              ActionButton(onPressed: () {}),
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
