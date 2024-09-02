import 'package:digi_task/core/constants/path/image_paths.dart';
import 'package:digi_task/core/utility/extension/image_path_ext.dart';
import 'package:digi_task/data/model/response/user_task_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventsDialog extends StatelessWidget {
  final Meetings meeting;

  const EventsDialog({super.key, required this.meeting});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          Image.asset(
            ImagePath.cardinfo.toPathPng,
            height: 200,
            fit: BoxFit.contain,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20.0, bottom: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meeting.title ?? "Başlıq Yoxdur",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  meeting.meetingType ?? 'Növ yoxdur',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                const Divider(),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.schedule_outlined),
                    const SizedBox(width: 5),
                    Text(
                      DateFormat('EEEE, MMM d, yyyy')
                          .format(DateTime.parse(meeting.date!)),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Text(
                  'Təsviri',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  meeting.meetingDescription ?? "Təsvir təqdim edilməyib",
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
