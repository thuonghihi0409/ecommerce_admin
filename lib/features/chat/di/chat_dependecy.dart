import 'package:thuongmaidientu/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:thuongmaidientu/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:thuongmaidientu/features/chat/domain/repositories/chat_repository.dart';
import 'package:thuongmaidientu/features/chat/domain/usecases/create_conversation_usecase.dart';
import 'package:thuongmaidientu/features/chat/domain/usecases/find_conversation_usecase.dart';
import 'package:thuongmaidientu/features/chat/domain/usecases/get_list_conversation_usecase.dart';
import 'package:thuongmaidientu/features/chat/domain/usecases/get_message_usecase.dart';
import 'package:thuongmaidientu/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:thuongmaidientu/features/chat/presentation/bloc/profile_bloc/chat_bloc.dart';
import 'package:thuongmaidientu/get_it.dart';

class ChatDependecy {
  static void init() {
    sl.registerFactory(() => ChatBloc(sl(), sl(), sl(), sl(), sl()));

    //// Chat UseCase
    sl.registerLazySingleton(() => GetListConversationUseCase(sl()));
    sl.registerLazySingleton(() => CreateConversationUsecase(sl()));
    sl.registerLazySingleton(() => SendMessageUsecase(sl()));
    sl.registerLazySingleton(() => GetMessageUseCase(sl()));
    sl.registerLazySingleton(() => FindConversationUsecase(sl()));

    sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(sl()));

    sl.registerLazySingleton<ChatRemoteDataSource>(
        () => ChatRemoteDataSourceImpl());
  }
}
