import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/chat/domain/entities/conversation_entity.dart';
import 'package:thuongmaidientu/features/chat/domain/entities/message_entity.dart';
import 'package:thuongmaidientu/features/chat/domain/usecases/create_conversation_usecase.dart';
import 'package:thuongmaidientu/features/chat/domain/usecases/find_conversation_usecase.dart';
import 'package:thuongmaidientu/features/chat/domain/usecases/get_list_conversation_usecase.dart';
import 'package:thuongmaidientu/features/chat/domain/usecases/get_message_usecase.dart';
import 'package:thuongmaidientu/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/profile_entity.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetListConversationUseCase getListConversationUseCase;
  final CreateConversationUsecase createConversationUsecase;
  final GetMessageUseCase getMessageUseCase;
  final SendMessageUsecase sendMessageUsecase;
  final FindConversationUsecase findConversationUsecase;
  ChatBloc(
      this.createConversationUsecase,
      this.getListConversationUseCase,
      this.getMessageUseCase,
      this.sendMessageUsecase,
      this.findConversationUsecase)
      : super(ChatState.empty()) {
    on<GetListConversation>(getListConversation);
    on<CreateConversation>(createConversation);
    on<SendMessage>(sendMessage);
    on<GetMessage>(getMessage);
    on<OpenConversation>(openConversation);
  }

  Future<void> getListConversation(
      GetListConversation event, Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      final listConversation =
          await getListConversationUseCase.call(event.userId);

      emit(
          state.copyWith(isLoading: false, listConversation: listConversation));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          listConversation: state.listConversation
              ?.copyWith(errorMessage: ParseError.fromJson(e).message)));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  Future<void> createConversation(
      CreateConversation event, Emitter<ChatState> emit) async {
    try {
      emit(
        state.copyWith(isLoading: true, listMessage: const ListModel()),
      );
      final response =
          await findConversationUsecase.call(event.user.id, event.store.id);
      if (response == null) {
        emit(state.copyWith(
          isLoading: false,
          conversation: ConversationEntity(
              id: "", user: event.user, store: event.store, unreadCount: 0),
        ));
        event.onSuccess?.call(
            ConversationEntity(
                id: "", user: event.user, store: event.store, unreadCount: 0),
            true);
      } else {
        event.onSuccess?.call(response, false);
        emit(state.copyWith(isLoading: false, conversation: response));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  Future<void> sendMessage(SendMessage event, Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      if (state.conversation?.id == null ||
          (state.conversation?.id ?? "").isEmpty) {
        final conversation = await createConversationUsecase.call(
            state.conversation?.user?.id ?? "hi",
            state.conversation?.store?.id ?? "ha");

        emit(state.copyWith(
          conversation: conversation,
        ));
      }

      final response = await sendMessageUsecase.call(
          event.senderId,
          event.receiverId,
          event.content,
          state.conversation?.id ?? "",
          convertMessageTypeToString(event.messageType));
      final newList =
          List<MessageEntity>.from(state.listMessage?.results ?? []);
      newList.insert(0, response!);
      final listmodel = ListModel(results: newList);
      emit(state.copyWith(
        isLoading: false,
        listMessage: listmodel,
      ));
      GetListConversation(userId: event.senderId);
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  Future<void> getMessage(GetMessage event, Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      if (state.conversation?.id == null ||
          (state.conversation?.id ?? "").isEmpty) return;

      final response =
          await getMessageUseCase.call(state.conversation?.id ?? "");
      emit(state.copyWith(isLoading: false, listMessage: response));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  Future<void> openConversation(
      OpenConversation event, Emitter<ChatState> emit) async {
    emit(state.copyWith(
        conversation: event.conversationEntity,
        listMessage: const ListModel()));
  }
}
