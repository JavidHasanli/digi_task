import 'package:digi_task/core/constants/path/image_paths.dart';
import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/core/utility/extension/image_path_ext.dart';
import 'package:digi_task/notifier/home/main/main_notifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrganizationsCard extends StatelessWidget {
  const OrganizationsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainNotifier>(builder: (context, notifier, child) {
      if (notifier.userTaskModel?.meetings?.isNotEmpty ?? false) {
        final dateTime = DateTime.parse(
          notifier.userTaskModel?.meetings?.first.date ?? '2002-02-27T14:00:00-08:00',
        );
        String formattedDate = DateFormat('MMM d, HH:mm').format(dateTime);

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
              context.colors.primaryColor80,
              context.colors.primaryColor70,
              context.colors.primaryColor60,
              context.colors.primaryColor50,
              context.colors.primaryColor30,
            ]),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.schedule,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              formattedDate,
                              style: context.typography.body1SemiBold.copyWith(color: context.colors.neutralColor100),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          '${notifier.userTaskModel?.meetings?.first.title}',
                          style: context.typography.h6SemiBold.copyWith(color: context.colors.neutralColor100),
                        ),
                      ],
                    ),
                    Image.asset(
                      ImagePath.cardinfo.toPathPng,
                      height: 130,
                      width: 130,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${notifier.userTaskModel?.meetings?.first.meetingType}',
                      style: context.typography.subtitle2SemiBold.copyWith(color: context.colors.neutralColor100),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
