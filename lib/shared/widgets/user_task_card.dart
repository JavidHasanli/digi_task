import 'package:digi_task/core/constants/path/icon_path.dart';
import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/core/utility/extension/icon_path_ext.dart';
import 'package:digi_task/notifier/home/main/main_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UserTaskCard extends StatelessWidget {
  const UserTaskCard({
    super.key,
    required this.name,
    required this.time,
    required this.location,
    required this.number,
    required this.status,
    required this.notifier,
    required this.iconRow,
    required this.group,
    this.button,
  });
  final String name;
  final String time;
  final String location;
  final String number;
  final String status;
  final dynamic notifier;
  final Widget iconRow;
  final String? group;
  final Widget? button;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.neutralColor100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      name,
                      maxLines: 1,
                      style: context.typography.subtitle1SemiBold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  iconRow,
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    IconPath.location.toPathSvg,
                    height: 16,
                    width: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      location,
                      overflow: TextOverflow.ellipsis,
                      style: context.typography.body2Medium.copyWith(
                        color: context.colors.primaryColor50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    IconPath.clock.toPathSvg,
                    height: 16,
                    width: 16,
                    color: context.colors.neutralColor50,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    time,
                    style: context.typography.body2Medium.copyWith(
                      color: context.colors.neutralColor50,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            if (context.watch<MainNotifier>().isAdmin)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          IconPath.phonegreen.toPathSvg,
                          height: 16,
                          width: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          number,
                          style: context.typography.body2Medium.copyWith(
                            color: context.colors.successColor60,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          IconPath.unemployer.toPathSvg,
                          height: 16,
                          width: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          group ?? 'Empty Group',
                          style: context.typography.body2Medium.copyWith(
                            color: context.colors.neutralColor40,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: status == 'waiting'
                                ? context.colors.secondaryColor50
                                : context.colors.primaryColor50,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4,
                            ),
                            child: Text(
                              status,
                              style:
                                  context.typography.overlineSemiBold.copyWith(
                                color: status == 'waiting'
                                    ? context.colors.neutralColor40
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      IconPath.phonegreen.toPathSvg,
                      height: 18,
                      width: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      number,
                      style: context.typography.body1SemiBold.copyWith(
                        color: context.colors.successColor60,
                      ),
                    ),
                    const Spacer(),
                    button ?? const SizedBox.shrink(),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
