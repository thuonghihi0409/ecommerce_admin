import 'package:thuongmaidientu/features/chat/domain/entities/conversation_entity.dart';
import 'package:thuongmaidientu/features/chat/domain/repositories/chat_repository.dart';

class FindConversationUsecase {
  final ChatRepository repository;

  FindConversationUsecase(this.repository);

  Future<ConversationEntity?> call(String userId, String storeId) async {
    return repository.findConversation(userId, storeId);
  }
}
