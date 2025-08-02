import 'package:thuongmaidientu/features/chat/domain/entities/message_entity.dart';
import 'package:thuongmaidientu/features/chat/domain/repositories/chat_repository.dart';

class SendMessageUsecase {
  final ChatRepository repository;

  SendMessageUsecase(this.repository);

  Future<MessageEntity?> call(String senderId, String receiverId,
      String message, String conversationId, String type) async {
    return repository.sendMessage(
        senderId, receiverId, message, conversationId, type);
  }
}
