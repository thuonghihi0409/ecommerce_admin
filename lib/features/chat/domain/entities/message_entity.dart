import 'package:thuongmaidientu/features/product/domain/entities/product.dart';

enum MessageType { message, product, media }

String convertMessageTypeToString(MessageType type) {
  switch (type) {
    case MessageType.message:
      return 'message';
    case MessageType.product:
      return 'product';
    case MessageType.media:
      return 'media';
  }
}

MessageType convertStringToMessageType(String type) {
  switch (type) {
    case 'message':
      return MessageType.message;
    case 'product':
      return MessageType.product;
    default:
      return MessageType.media;
  }
}

class MessageEntity {
  String id;
  String? content;
  bool? isRead;
  DateTime? timesend;
  String? conversationId;
  String? senderId;
  String receiverId;
  Product? product;
  MessageType messageType;

  MessageEntity(
      {required this.id,
      required this.content,
      required this.isRead,
      required this.timesend,
      required this.conversationId,
      required this.senderId,
      required this.messageType,
      required this.receiverId,
      required this.product});
}
