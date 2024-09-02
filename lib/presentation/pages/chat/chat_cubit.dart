import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(const ChatState(messages: [], groupedMessages: {}));

  void updateMessages(List<dynamic> messages) {
    final groupedMessages = _groupMessagesByDate(messages);
    emit(ChatState(messages: messages, groupedMessages: groupedMessages));
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
}

class ChatState extends Equatable {
  final List<dynamic> messages;
  final Map<String, List<dynamic>> groupedMessages;

  const ChatState({required this.messages, required this.groupedMessages});

  @override
  List<Object> get props => [messages, groupedMessages];
}
