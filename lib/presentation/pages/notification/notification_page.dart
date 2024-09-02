import 'package:digi_task/presentation/pages/notification/services/websocket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digi_task/core/constants/path/icon_path.dart';
import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/core/utility/extension/icon_path_ext.dart';
import 'package:digi_task/data/services/local/secure_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';


import 'notification_cubit.dart';


class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final SecureService secureService = SecureService(
    secureStorage: const FlutterSecureStorage(),
  );
  final WebSocketService _webSocketService = WebSocketService();
  List<Map<String, String>> notifications = [];

  @override
  void initState() {
    super.initState();
    context
        .read<NotificationCubit>()
        .loadInitialNotificationCount(notifications);
    _connectWebSocket();
  }

  Future<void> _connectWebSocket() async {
    final token = await secureService.accessToken;

    if (token == null) {
      throw Exception('No access token or email available');
    }

    await _webSocketService.connectWebSocket(
      onMessageReceived: (decodedMessages) {
        setState(() {
          notifications.addAll(decodedMessages);
          context
              .read<NotificationCubit>()
              .loadInitialNotificationCount(notifications);

          print(
              "Updated notification number: ${context.read<NotificationCubit>().state}");
        });
      },
      onError: () async {
        await Future.delayed(const Duration(seconds: 5));
        _connectWebSocket();
      },
      onDone: () async {
        await Future.delayed(const Duration(seconds: 5));
        _connectWebSocket();
      },
    );
  }

  @override
  void dispose() {
    _webSocketService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: SvgPicture.asset(IconPath.arrowleft.toPathSvg)),
        title: Text('Bildirişlər', style: context.typography.subtitle2Medium),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification['email']!,
                  style: const TextStyle(color: Colors.blue),
                ),
                const SizedBox(height: 4),
                Text(
                  notification['message']!,
                  style: context.typography.body2Regular
                      .copyWith(color: context.colors.neutralColor40),
                ),
                const SizedBox(height: 4),
                Text(
                  notification['date']!,
                  style: context.typography.body2Regular
                      .copyWith(color: context.colors.neutralColor70),
                ),
                const Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}
