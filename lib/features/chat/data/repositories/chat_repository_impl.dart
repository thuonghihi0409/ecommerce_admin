import 'package:thuongmaidientu/features/chat/data/models/conversation_model.dart';
import 'package:thuongmaidientu/features/chat/data/models/message_model.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_datasource.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<ListModel<ConversationModel>> getListConversation(
      String userId) async {
    final result = await remoteDataSource.getListConversation(userId);
    return result;
  }

  @override
  Future<ConversationModel> createConversation(
      String userId, String storeId) async {
    final result = await remoteDataSource.createConversation(userId, storeId);
    return result;
  }

  @override
  Future<ConversationModel?> findConversation(
      String userId, String storeId) async {
    final result = await remoteDataSource.findConversation(userId, storeId);
    return result;
  }

  @override
  Future<ListModel<MessageModel>> getMessage(String conversationId) async {
    final result = await remoteDataSource.getMessage(conversationId);
    return result;
  }

  @override
  Future<MessageModel> sendMessage(String senderId, String receiverId,
      String message, String conversationId, String type) async {
    final result = await remoteDataSource.sendMessage(
        senderId, receiverId, message, conversationId, type);
    return result;
  }
}
