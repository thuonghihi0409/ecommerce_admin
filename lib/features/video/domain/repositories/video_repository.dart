import 'package:thuongmaidientu/features/video/domain/entities/video_entity.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

abstract class VideoRepository {
  Future<ListModel<VideoEntity>> getListVideo(String id);
}
