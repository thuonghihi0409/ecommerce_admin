import 'package:thuongmaidientu/features/chat/domain/entities/message_entity.dart';
import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/profile_entity.dart';

class ConversationEntity {
  String? id;
  ProfileEntity? user;
  Store? store;
  MessageEntity? lastMessage;
  int unreadCount;
  // Constructor
  ConversationEntity(
      {required this.id,
      this.user,
      this.store,
      this.lastMessage,
      required this.unreadCount});
}
