import 'package:digi_task/core/constants/routes.dart';
import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/core/utility/extension/icon_path_ext.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/path/icon_path.dart';
import '../../../../presentation/pages/home/widgets/profile_card_item.dart';

class OtherTab extends StatelessWidget {
  const OtherTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 24),
      child: Column(
        children: [
          ProfileCardItem(
            onTap: () {
              context.goNamed(AppRoutes.profile.name);
            },
            title: "Profil",
            leadingIcon: IconPath.adminprofile.toPathSvg,
            trailingIcon: IconPath.arrowright.toPathSvg,
            sytle: context.typography.subtitle2Medium
                .copyWith(color: context.colors.neutralColor20),
          ),
          const SizedBox(
            height: 8,
          ),
          ProfileCardItem(
            onTap: () {
              context.goNamed(AppRoutes.anbar.name);
            },
            title: "Anbar",
            leadingIcon: IconPath.anbar.toPathSvg,
            trailingIcon: IconPath.arrowright.toPathSvg,
            sytle: context.typography.subtitle2Medium
                .copyWith(color: context.colors.neutralColor20),
          ),
          const SizedBox(
            height: 8,
          ),
          ProfileCardItem(
            onTap: () {
              context.goNamed(AppRoutes.isciler.name);
            },
            title: "İşçilər",
            leadingIcon: IconPath.employers.toPathSvg,
            trailingIcon: IconPath.arrowright.toPathSvg,
            sytle: context.typography.subtitle2Medium
                .copyWith(color: context.colors.neutralColor20),
          ),
        ],
      ),
    );
  }
}
