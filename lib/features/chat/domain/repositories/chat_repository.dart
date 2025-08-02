import 'package:thuongmaidientu/features/chat/domain/entities/conversation_entity.dart';
import 'package:thuongmaidientu/features/chat/domain/entities/message_entity.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

abstract class ChatRepository {
  Future<ListModel<ConversationEntity>> getListConversation(String userId);
  Future<ConversationEntity> createConversation(String userId, String storeId);
  Future<ConversationEntity?> findConversation(String userId, String storeId);
  Future<ListModel<MessageEntity>> getMessage(String conversationId);
  Future<MessageEntity> sendMessage(String senderId, String receiverId,
      String message, String conversationId, String type);
}
