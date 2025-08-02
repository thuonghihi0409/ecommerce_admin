import 'package:thuongmaidientu/features/review/data/datasources/review_remote_datasource.dart';
import 'package:thuongmaidientu/features/review/data/repositories/review_repository_impl.dart';
import 'package:thuongmaidientu/features/review/domain/repositories/review_repository.dart';
import 'package:thuongmaidientu/features/review/domain/usecases/create_review_usecase.dart';
import 'package:thuongmaidientu/features/review/domain/usecases/get_list_review_usecase.dart';
import 'package:thuongmaidientu/features/review/presentation/bloc/review_bloc/review_bloc.dart';
import 'package:thuongmaidientu/get_it.dart';

class ReviewDependecy {
  static void init() {
    sl.registerFactory(() => ReviewBloc(sl(), sl()));

    //// Review UseCase
    sl.registerLazySingleton(() => GetListReviewUseCase(sl()));
    sl.registerLazySingleton(() => CreateReviewUsecase(sl()));

    sl.registerLazySingleton<ReviewRepository>(
        () => ReviewRepositoryImpl(sl()));

    sl.registerLazySingleton<ReviewRemoteDatasource>(
        () => ReviewRemoteDataSourceImpl());
  }
}
