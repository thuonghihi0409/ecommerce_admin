import 'package:thuongmaidientu/features/chat/domain/entities/message_entity.dart';
import 'package:thuongmaidientu/features/chat/domain/repositories/chat_repository.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

class GetMessageUseCase {
  final ChatRepository repository;

  GetMessageUseCase(this.repository);

  Future<ListModel<MessageEntity>?> call(String conversationId) async {
    return repository.getMessage(conversationId);
  }
}
