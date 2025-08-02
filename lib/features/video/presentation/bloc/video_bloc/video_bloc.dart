import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/video/domain/entities/video_entity.dart';
import 'package:thuongmaidientu/features/video/domain/usecases/get_list_video_usecase.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final GetListVideoUseCase _getListVideoUseCase;

  VideoBloc(
    this._getListVideoUseCase,
  ) : super(VideoState.empty()) {
    on<GetListVideo>(_getListVideo);
  }

  void _getListVideo(GetListVideo event, Emitter<VideoState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await Future.delayed(const Duration(seconds: 1));
      final listVideo = await _getListVideoUseCase.call(event.id ?? "");
      emit(state.copyWith(isLoading: false, listVideo: listVideo));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          listVideo: state.listVideo
              .copyWith(errorMessage: ParseError.fromJson(e).message)));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }
}
