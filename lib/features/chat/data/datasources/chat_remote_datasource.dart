import 'package:thuongmaidientu/features/chat/data/models/message_model.dart';
import 'package:thuongmaidientu/features/chat/domain/entities/message_entity.dart';
import 'package:thuongmaidientu/shared/service/supabase_client.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../models/conversation_model.dart';

abstract class ChatRemoteDataSource {
  Future<ListModel<ConversationModel>> getListConversation(String userId);
  Future<ConversationModel> createConversation(String userId, String storeId);
  Future<ListModel<MessageModel>> getMessage(String conversationId);
  Future<MessageModel> sendMessage(String senderId, String receiverId,
      String message, String conversationId, String type);
  Future<ConversationModel?> findConversation(String userId, String storeId);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  ChatRemoteDataSourceImpl();

  @override
  Future<ListModel<ConversationModel>> getListConversation(
      String userId) async {
    final result = await supabase.from('Conversations').select('''
      *,
      user: Users(*),
      store: Stores(*),
      last_message: Messages!Conversations_last_message_id_fkey(*, product: Products(*, store: Stores(*)))
    ''').or('user_id.eq.$userId,store_id.eq.$userId');

    final listConversation = result
        .map((conversation) => ConversationModel.fromJson(conversation))
        .toList();
    return ListModel(results: listConversation);
  }

  @override
  Future<ConversationModel> createConversation(
      String userId, String storeId) async {
    final conversation = await supabase
        .from('Conversations')
        .insert({"user_id": userId, "store_id": storeId}).select('''
        *,
        user: Users(*),
        store:Stores(*),
       
        last_message:Messages!Conversations_last_message_id_fkey(*)
        ''').single();

    return ConversationModel.fromJson(conversation);
  }

  @override
  Future<ConversationModel?> findConversation(
      String userId, String storeId) async {
    final result = await supabase.from('Conversations').select('''
      *,
      user: Users(*),
      store:Stores(*),
      last_message:Messages!Conversations_last_message_id_fkey(*)
      ''').eq('user_id', userId).eq('store_id', storeId).maybeSingle();
    if (result != null) {
      return ConversationModel.fromJson(result);
    }
    return null;
  }

  @override
  Future<ListModel<MessageModel>> getMessage(String conversationId) async {
    final result = await supabase
        .from('Messages')
        .select('''
    *,
    product: Products(*,store : Stores(*))
    ''')
        .eq('conversation_id', conversationId)
        .order('created_at', ascending: false);

    final listConversation = result
        .map((conversation) => MessageModel.fromJson(conversation))
        .toList();
    return ListModel(results: listConversation);
  }

  @override
  Future<MessageModel> sendMessage(String senderId, String receiverId,
      String message, String conversationId, String type) async {
    final result = await supabase.from('Messages').insert({
      "sender_id": senderId,
      "receiver_id": receiverId,
      "conversation_id": conversationId,
      "content": message,
      "message_type": type,
      "product_id": convertStringToMessageType(type) == MessageType.product
          ? message
          : null
    }).select('''
      *,
      product: Products(*,store : Stores(*))
      ''').single();

    await supabase.from("Conversations").update(
        {"last_message_id": result["id"]}).eq("id", result["conversation_id"]);
    return MessageModel.fromJson(result);
  }
}
