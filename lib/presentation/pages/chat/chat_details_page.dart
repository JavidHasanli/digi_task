import 'dart:convert';

import 'package:digi_task/core/constants/path/icon_path.dart';
import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/core/utility/extension/icon_path_ext.dart';
import 'package:digi_task/data/services/local/secure_service.dart';
import 'package:digi_task/presentation/pages/chat/chat_cubit.dart';
import 'package:digi_task/presentation/pages/chat/chat_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatDetailsPage extends StatefulWidget {
  final int? groupId;
  final String? groupName;

  const ChatDetailsPage({super.key, this.groupId, this.groupName});

  @override
  State<ChatDetailsPage> createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends State<ChatDetailsPage> {
  final ChatCubit _chatCubit = ChatCubit();
  final SecureService secureService = SecureService(
    secureStorage: const FlutterSecureStorage(),
  );
  Map<String, List<dynamic>> groupedMessages = {};
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  WebSocketChannel? channel;
  late final MessageService _messageService;
  _ChatDetailsPageState() : _messageService = MessageService(dio: Dio());

  Future<void> _fetchMessages() async {
    try {
      final allMessages = await _messageService.fetchMessages(widget.groupId);

      setState(() {
        groupedMessages = _groupMessagesByDate(allMessages);
        scrollToBottom();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Xəta: $e')),
      );
    }
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Map<String, List<dynamic>> _groupMessagesByDate(List<dynamic> messages) {
    final Map<String, List<dynamic>> grouped = {};
    for (final message in messages) {
      final timestamp = DateTime.parse(message['timestamp']);
      final date = DateFormat('dd MMM yyyy').format(timestamp);
      if (grouped[date] == null) {
        grouped[date] = [];
      }
      grouped[date]!.add(message);
    }
    return grouped;
  }

  Future<void> connectWebSocketChat() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = await secureService.accessToken;
      if (token == null) {
        throw Exception('No access token available');
      }

      final email = prefs.getString('saved_email');

      channel = WebSocketChannel.connect(
        Uri.parse('ws://135.181.42.192/chat/?email=$email&token=$token'),
      );

      channel!.stream.listen(
        (event) {
          print("Chat Received raw WebSocket message: $event");
          final data = jsonDecode(event) as Map<String, dynamic>;
          final email = data['email'];
          if (email != null) {
            prefs.setString('socketEmail', email);
          } else {
            final socketEmail = prefs.getString('socketEmail');
            final typeM =
                data['user']['email'] == socketEmail ? 'sent' : 'received';
            data['typeM'] = typeM;

            final updatedMessages = List.from(_chatCubit.state.messages)
              ..add(data);
            _chatCubit.updateMessages(updatedMessages);
            _fetchMessages();
          }
        },
        onError: (error) async {
          print("WebSocketChat error: $error");
          try {
            connectWebSocketChat();
          } catch (refreshError) {
            print('Chat Error refreshing token: $refreshError');
          }
        },
        onDone: () async {
          print("WebSocketChat connection closed.");
          if (channel != null && channel!.closeCode != null) {
            setState(() {
              channel = null;
            });
            await Future.delayed(const Duration(seconds: 5));
            connectWebSocketChat();
          }
        },
      );
    } catch (error) {
      print('WebSocketChat connection error: $error');
    }
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      final message = {
        "content": _messageController.text,
        "room": widget.groupId,
        "timestamp": DateTime.now().toIso8601String(),
        "typeM": "sent",
        "user": {"first_name": "Me"},
      };

      await Future.delayed(const Duration(milliseconds: 300));

      channel?.sink.add(jsonEncode(message));
      _chatCubit
          .updateMessages(List.from(_chatCubit.state.messages)..add(message));

      scrollToBottom();

      _messageController.clear();
      await _fetchMessages();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMessages();
    connectWebSocketChat();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: SvgPicture.asset(IconPath.arrowleft.toPathSvg),
          ),
          title: Text(widget.groupName ?? 'Sohbet qrupu',
              style: context.typography.subtitle2Medium),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  return ListView(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: groupedMessages.entries.expand((entry) {
                      final date = entry.key;
                      final messages = entry.value;

                      return [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Center(
                            child: Text(
                              date,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        ...messages.map((message) {
                          final isSent = message['typeM'] == 'sent';
                          final user = message['user']['first_name'];
                          final content = message['content'];
                          final timestamp = message['timestamp'];
                          final dateTime = DateTime.parse(timestamp);
                          final formattedTime =
                              DateFormat('HH:mm').format(dateTime);

                          return Align(
                            alignment: isSent
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment: isSent
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (!isSent)
                                    CircleAvatar(
                                      backgroundColor: Colors.grey[400],
                                      child: Text(
                                        user[0].toUpperCase(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        decoration: BoxDecoration(
                                          color: isSent
                                              ? Colors.blueAccent
                                              : Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (!isSent)
                                              Text(user,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: isSent
                                                        ? Colors.white
                                                        : Colors.black,
                                                  )),
                                            const SizedBox(height: 4),
                                            Text(content,
                                                style: TextStyle(
                                                  color: isSent
                                                      ? Colors.white
                                                      : Colors.black,
                                                )),
                                            const SizedBox(height: 4),
                                            Text(formattedTime,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: isSent
                                                      ? Colors.white70
                                                      : Colors.black54,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ];
                    }).toList(),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: "Mesaj yaz",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send),
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    channel?.sink.close();
    super.dispose();
  }
}
