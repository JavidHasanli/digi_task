import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/core/utility/extension/icon_path_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/path/icon_path.dart';
import '../../../../notifier/home/main/main_notifier.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ColoredBox(
        color: context.colors.neutralColor100,
        child: TabBar(
          onTap: (value) {
            widget.tabController.index = value;
            setState(() {});
          },
          dividerColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          padding: const EdgeInsets.only(bottom: 8, top: 8),
          controller: widget.tabController,
          labelPadding: EdgeInsets.zero,
          labelColor: context.colors.primaryColor50,
          labelStyle: context.typography.overlineSemiBold.copyWith(color: context.colors.neutralColor40),
          tabs: [
            Tab(
              text: "Ana səhifə",
              icon: SvgPicture.asset(
                widget.tabController.index == 0 ? IconPath.selecthome.toPathSvg : IconPath.home.toPathSvg,
                height: 22,
                width: 22,
              ),
            ),
            Tab(
              text: "Performans",
              icon: SvgPicture.asset(
                widget.tabController.index == 1 ? IconPath.selectperformance.toPathSvg : IconPath.performance.toPathSvg,
                height: 22,
                width: 22,
              ),
            ),
            Tab(
              text: "Tasklar",
              icon: SvgPicture.asset(
                widget.tabController.index == 2 ? IconPath.selecttask.toPathSvg : IconPath.task.toPathSvg,
                height: 22,
                width: 22,
              ),
            ),
            context.watch<MainNotifier>().isAdmin
                ? Tab(
                    text: "Digər",
                    icon: SvgPicture.asset(
                      widget.tabController.index == 3 ? IconPath.selectedother.toPathSvg : IconPath.other.toPathSvg,
                      height: 22,
                      width: 22,
                    ),
                  )
                :
            Tab(
              text: "Profil",
              icon: SvgPicture.asset(
                widget.tabController.index == 3 ? IconPath.selectprofile.toPathSvg : IconPath.profile.toPathSvg,
                height: 22,
                width: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
