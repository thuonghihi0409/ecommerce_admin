import 'package:thuongmaidientu/features/video/domain/entities/video_entity.dart';
import 'package:thuongmaidientu/features/video/domain/repositories/video_repository.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../datasources/video_remote_datasource.dart';

class VideoRepositoryImpl implements VideoRepository {
  final VideoRemoteDatasource remoteDataSource;

  VideoRepositoryImpl(this.remoteDataSource);

  @override
  Future<ListModel<VideoEntity>> getListVideo(String id) async {
    final userModel = await remoteDataSource.getListVideo(id);
    return userModel;
  }
}
