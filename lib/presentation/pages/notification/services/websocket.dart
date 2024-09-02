import 'dart:convert';
import 'package:digi_task/data/services/local/secure_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:intl/intl.dart';

class WebSocketService {
  WebSocketChannel? _channel;

  WebSocketChannel? get channel => _channel;
  final SecureService secureService = SecureService(
    secureStorage: const FlutterSecureStorage(),
  );

  Future<void> connectWebSocket({
     Function(List<Map<String, String>>)? onMessageReceived,
     Function()? onError,
     Function()? onDone,
  }) async {
    try {
      final token = await secureService.accessToken;

      final url = 'ws://135.181.42.192/notification/?token=$token';
      print('Connecting to WebSocket: $url');

      _channel = WebSocketChannel.connect(Uri.parse(url));

      _channel!.stream.listen(
        (message) {
          print("Notification Received raw WebSocket message: $message");

          final data = jsonDecode(message);
          final List<Map<String, String>> decodedMessages =
              (data['message'] as List).map((notification) {
            String decodedMessage = notification['message'];
            String decodedEmail = notification['user_email'];

            String formattedDate =
                DateFormat('d MMMM yyyy', 'az').format(DateTime.now());

            return {
              'message': decodedMessage,
              'email': decodedEmail,
              'date': formattedDate,
            };
          }).toList();

          onMessageReceived!(decodedMessages);
        },
        onError: (error) async {
          print("WebSocket error: $error");
          onError!();
        },
        onDone: () async {
          print("WebSocket connection closed.");
          onDone!();
        },
      );
    } catch (error) {
      print('WebSocket connection error: $error');
      onError!();
    }
  }

  void dispose() {
    _channel?.sink.close();
  }
}
