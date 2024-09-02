import 'package:digi_task/core/constants/path/icon_path.dart';
import 'package:digi_task/core/constants/routes.dart';
import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/core/utility/extension/icon_path_ext.dart';
import 'package:digi_task/features/profile/presentation/notifier/profile_notifier.dart';
import 'package:digi_task/features/profile/presentation/notifier/profile_state.dart';
import 'package:digi_task/notifier/home/main/main_notifier.dart';
import 'package:digi_task/presentation/components/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../notifier/auth/auth_notifier.dart';
import '../../../../presentation/pages/home/widgets/profile_card_item.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MainNotifier>().checkAdmin();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = context.watch<MainNotifier>().isAdmin;
    print('Is Admin: $isAdmin');

    return Scaffold(
        backgroundColor: context.colors.backgroundColor,
        appBar: isAdmin
            ? AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                leading: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: SvgPicture.asset(IconPath.arrowleft.toPathSvg)),
                title:
                    Text('Profil', style: context.typography.subtitle2Medium),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(IconPath.menu.toPathSvg)),
                  )
                ],
              )
            : null,
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 24),
          child: Consumer<ProfileNotifier>(builder: (context, notifier, child) {
            if (notifier.state is ProfileProgress) {
              return const Center(
                child: CustomProgressIndicator(),
              );
            } else if (notifier.state is ProfileFailure) {
              const Center(
                child: Text("Error"),
              );
            } else if (notifier.state is ProfileSuccess) {
              final userModel = (notifier.state as ProfileSuccess).userModel;
              return Column(
                children: [
                  ProfileCardItem(
                    title: userModel.firstName ?? "User not found",
                    subtitle: userModel.email,
                    trailingIcon: IconPath.arrowright.toPathSvg,
                    onTap: () {
                      context.goNamed(AppRoutes.profileEdit.name,
                          extra: userModel);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ProfileCardItem(
                    onTap: () {},
                    title: "Bildirişlər",
                    isNotification: true,
                    leadingIcon: IconPath.profnoti.toPathSvg,
                    trailingIcon: IconPath.arrowright.toPathSvg,
                  ),
                  ProfileCardItem(
                    onTap: () {},
                    title: "Dəstək",
                    leadingIcon: IconPath.more.toPathSvg,
                    trailingIcon: IconPath.arrowright.toPathSvg,
                  ),
                  ProfileCardItem(
                    onTap: () {},
                    title: "Haqqında",
                    leadingIcon: IconPath.info.toPathSvg,
                    trailingIcon: IconPath.arrowright.toPathSvg,
                  ),
                  ProfileCardItem(
                    isExit: true,
                    title: "Çıxış et",
                    leadingIcon: IconPath.logout.toPathSvg,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            insetPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            child: Material(
                              borderRadius: BorderRadius.circular(24),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 26.0, horizontal: 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Center(
                                        child: Text(
                                          "Çıxış",
                                          style: context
                                              .typography.subtitle1Medium,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        'Çıxış etmək istədiyinizdən əminsiniz?',
                                        style: context.typography.body2Regular
                                            .copyWith(
                                                color: context
                                                    .colors.neutralColor50),
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                padding:
                                                    WidgetStateProperty.all(
                                                        const EdgeInsets.all(
                                                            16)),
                                                shape: WidgetStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                                backgroundColor:
                                                    WidgetStateProperty.all(
                                                        Colors.white),
                                                side: WidgetStateProperty.all(
                                                  BorderSide(
                                                      color: context.colors
                                                          .primaryColor50),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Ləğv et',
                                                style: context
                                                    .typography.body2SemiBold
                                                    .copyWith(
                                                        color: context.colors
                                                            .primaryColor50),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                padding:
                                                    WidgetStateProperty.all(
                                                        const EdgeInsets.all(
                                                            16)),
                                                shape: WidgetStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                                backgroundColor:
                                                    WidgetStateProperty.all(
                                                        context.colors
                                                            .errorColor50),
                                                side: WidgetStateProperty.all(
                                                  BorderSide(
                                                      color: context
                                                          .colors.errorColor50),
                                                ),
                                              ),
                                              onPressed: context
                                                  .read<AuthNotifier>()
                                                  .logOut,
                                              child: context
                                                          .watch<AuthNotifier>()
                                                          .authState ==
                                                      AuthState.progress
                                                  ? const Center(
                                                      child:
                                                          CustomProgressIndicator(),
                                                    )
                                                  : Text(
                                                      'Çıxış et',
                                                      style: context.typography
                                                          .body2SemiBold
                                                          .copyWith(
                                                              color: context
                                                                  .colors
                                                                  .neutralColor100),
                                                    ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          }),
        ));
  }
}
