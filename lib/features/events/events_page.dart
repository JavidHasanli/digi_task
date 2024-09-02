import 'package:digi_task/core/constants/path/icon_path.dart';
import 'package:digi_task/core/constants/path/image_paths.dart';
import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/core/utility/extension/icon_path_ext.dart';
import 'package:digi_task/core/utility/extension/image_path_ext.dart';
import 'package:digi_task/features/events/widget/events_dialog.dart';
import 'package:digi_task/notifier/home/main/main_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: SvgPicture.asset(IconPath.arrowleft.toPathSvg),
        ),
        title: Text('Tədbirlər', style: context.typography.subtitle2Medium),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(IconPath.menu.toPathSvg),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<MainNotifier>(
          builder: (context, notifier, child) {
            return FutureBuilder(
              future: notifier.fetchMeetings(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Failed to load events',
                        style: context.typography.body1SemiBold),
                  );
                } else {
                  if (notifier.meetings.isNotEmpty) {
                    return ListView.builder(
                      itemCount: notifier.meetings.length,
                      itemBuilder: (context, index) {
                        final meeting = notifier.meetings[index];
                        final dateTime = DateTime.parse(meeting.date!);
                        String formattedDate =
                            DateFormat('MMM d, HH:mm').format(dateTime);

                        return GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return EventsDialog(meeting: meeting);
                                });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  context.colors.primaryColor80,
                                  context.colors.primaryColor70,
                                  context.colors.primaryColor60,
                                  context.colors.primaryColor50,
                                  context.colors.primaryColor30,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            margin: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.schedule,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                formattedDate,
                                                style: context
                                                    .typography.body1SemiBold
                                                    .copyWith(
                                                        color: context.colors
                                                            .neutralColor100),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                              meeting.title ?? 'No Title',
                                              style: context
                                                  .typography.h6SemiBold
                                                  .copyWith(
                                                      color: context.colors
                                                          .neutralColor100),
                                            ),
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
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        meeting.meetingType ?? 'No Type',
                                        style: context
                                            .typography.subtitle2SemiBold
                                            .copyWith(
                                                color: context
                                                    .colors.neutralColor100),
                                      ),
                                      const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.white)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              },
            );
          },
        ),
      ),
    );
  }
}

// void showEventDialog(BuildContext context, Meetings meeting) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: Image.asset(
//                 ImagePath.cardinfo.toPathPng,
//                 height: 200,
//                 width: 130,
//                 fit: BoxFit.contain,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(meeting.title ?? "No Title",
//                   style: const TextStyle(color: Colors.black)),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 4.0),
//               child: Text(
//                   DateFormat('EEEE, MMM d, yyyy')
//                       .format(DateTime.parse(meeting.date!)),
//                   style: const TextStyle(color: Colors.black)),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                   meeting.meetingDescription ?? "No description provided",
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(color: Colors.black)),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
