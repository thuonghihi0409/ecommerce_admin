import 'package:thuongmaidientu/features/video/domain/entities/video_entity.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../repositories/video_repository.dart';

class GetListVideoUseCase {
  final VideoRepository repository;

  GetListVideoUseCase(this.repository);

  Future<ListModel<VideoEntity>> call(String id) {
    return repository.getListVideo(id);
  }
}
