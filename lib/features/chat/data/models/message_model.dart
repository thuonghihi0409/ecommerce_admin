import 'package:thuongmaidientu/features/chat/domain/entities/message_entity.dart';
import 'package:thuongmaidientu/features/product/data/models/product_model.dart';

class MessageModel extends MessageEntity {
  MessageModel(
      {required super.id,
      required super.content,
      required super.isRead,
      required super.timesend,
      required super.conversationId,
      required super.senderId,
      required super.messageType,
      required super.receiverId,
      required super.product});

  // Phương thức chuyển đổi đối tượng Message thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'is_read': isRead,
      'conversation_id': conversationId,
      'sender_id': senderId ?? "",
      'receiver_id': receiverId,
      'message_type': convertMessageTypeToString(messageType)
    };
  }

  // Phương thức tạo đối tượng Message từ JSON
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        messageType: convertStringToMessageType(json["message_type"] ?? ""),
        id: json['id'],
        content: json['content'],
        isRead: json['is_read'] ?? true,
        timesend: DateTime.parse(json['created_at']).toUtc(),
        conversationId: json['conversation_id'],
        senderId: json['sender_id'],
        receiverId: json['receiver_id'],
        product: json['product'] != null
            ? ProductModel.fromJson(json['product'])
            : null);
  }
}
