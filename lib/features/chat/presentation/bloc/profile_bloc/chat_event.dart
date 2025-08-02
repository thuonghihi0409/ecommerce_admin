part of 'chat_bloc.dart';

class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class GetListConversation extends ChatEvent {
  final String userId;
  const GetListConversation({required this.userId});
}

class CreateConversation extends ChatEvent {
  final Function(ConversationEntity, bool)? onSuccess;
  final ProfileEntity user;
  final Store store;
  const CreateConversation(
      {required this.user, required this.store, this.onSuccess});
}

class GetMessage extends ChatEvent {
  const GetMessage();
}

class SendMessage extends ChatEvent {
  final bool isNew;
  final String content;
  final String senderId;
  final String receiverId;
  final MessageType messageType;
  const SendMessage(
      {required this.content,
      required this.receiverId,
      required this.senderId,
      required this.messageType,
      this.isNew = false});
}

class OpenConversation extends ChatEvent {
  final ConversationEntity? conversationEntity;
  const OpenConversation({required this.conversationEntity});
}

class ReceiveMessage extends ChatEvent {
  const ReceiveMessage();
}
