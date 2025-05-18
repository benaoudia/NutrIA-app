import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/chat_message.dart';
import '../services/chat_service.dart';

// Events
abstract class ChatEvent {}

class SendMessageEvent extends ChatEvent {
  final String message;
  SendMessageEvent(this.message);
}

// States
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<ChatMessage> messages;
  ChatLoaded(this.messages);
}

class ChatError extends ChatState {
  final String error;
  ChatError(this.error);
}

// BLoC
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatService chatService;
  final List<ChatMessage> _messages = [];

  ChatBloc(this.chatService) : super(ChatInitial()) {
    on<SendMessageEvent>(_onSendMessage);
  }

  Future<void> _onSendMessage(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    final userMessage = ChatMessage(
      message: event.message,
      isUser: true,
      timestamp: DateTime.now(),
    );
    _messages.add(userMessage);
    emit(ChatLoaded(List.from(_messages)));
    emit(ChatLoading());
    try {
      final botResponse = await chatService.sendMessage(event.message);
      final botMessage = ChatMessage(
        message: botResponse,
        isUser: false,
        timestamp: DateTime.now(),
      );
      _messages.add(botMessage);
      emit(ChatLoaded(List.from(_messages)));
    } catch (e) {
      emit(ChatError(e.toString()));
      emit(ChatLoaded(List.from(_messages)));
    }
  }
}
