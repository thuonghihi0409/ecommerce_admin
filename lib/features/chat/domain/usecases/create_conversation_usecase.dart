import 'package:thuongmaidientu/features/chat/domain/entities/conversation_entity.dart';
import 'package:thuongmaidientu/features/chat/domain/repositories/chat_repository.dart';

class CreateConversationUsecase {
  final ChatRepository repository;

  CreateConversationUsecase(this.repository);

  Future<ConversationEntity?> call(String userId, String storeId) async {
    return repository.createConversation(userId, storeId);
  }
}
