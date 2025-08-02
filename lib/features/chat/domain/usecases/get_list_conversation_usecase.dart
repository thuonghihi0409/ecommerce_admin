import 'package:thuongmaidientu/features/chat/domain/entities/conversation_entity.dart';
import 'package:thuongmaidientu/features/chat/domain/repositories/chat_repository.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

class GetListConversationUseCase {
  final ChatRepository repository;

  GetListConversationUseCase(this.repository);

  Future<ListModel<ConversationEntity>?> call(String userId) async {
    return repository.getListConversation(userId);
  }
}
