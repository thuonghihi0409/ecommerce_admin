import 'package:thuongmaidientu/features/chat/data/models/message_model.dart';
import 'package:thuongmaidientu/features/chat/domain/entities/conversation_entity.dart';
import 'package:thuongmaidientu/features/product/data/models/store_model.dart';
import 'package:thuongmaidientu/features/profile/data/models/profile_model.dart';

class ConversationModel extends ConversationEntity {
  ConversationModel(
      {required super.id,
      required super.user,
      required super.store,
      required super.unreadCount,
      required super.lastMessage});

  // From JSON
  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'],
      user: ProfileEntityModel.fromJson(json['user']),
      store: StoreModel.fromJson(json['store']),
      lastMessage: json['last_message'] != null
          ? MessageModel.fromJson(json['last_message'])
          : null,
      unreadCount: json['unread_count'] ?? 0,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'conversation_id': id,
      'user_id': user?.id,
      'store_id': store?.id,
      'last_message_id': lastMessage?.id ?? "",
      'unread_count': unreadCount
    };
  }
}
