import 'package:thuongmaidientu/shared/service/supabase_client.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../models/video_model.dart';

abstract class VideoRemoteDatasource {
  Future<ListModel<VideoModel>> getListVideo(String id);
}

class VideoRemoteDataSourceImpl implements VideoRemoteDatasource {
  VideoRemoteDataSourceImpl();

  @override
  Future<ListModel<VideoModel>> getListVideo(String id) async {
    final data = await supabase.from("Reviews").select('''
    *,
    image_urls: Images(url),
    user: Users(*),
    variant: Variants(*)
    ''').eq("product_id", id);

    final result = ListModel(
        results: data.map((product) => VideoModel.fromJson(product)).toList());

    return result;
  }
}
