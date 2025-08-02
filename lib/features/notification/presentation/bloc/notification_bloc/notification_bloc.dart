import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/notification/domain/entities/notification_entity.dart';
import 'package:thuongmaidientu/features/notification/domain/usecases/get_list_notification_usecase.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetListNotificationUseCase _getListNotificationUseCase;

  NotificationBloc(
    this._getListNotificationUseCase,
  ) : super(NotificationState.empty()) {
    on<GetListNotification>(_getListNotification);
  }

  void _getListNotification(
      GetListNotification event, Emitter<NotificationState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await Future.delayed(const Duration(seconds: 1));
      final listNotification =
          await _getListNotificationUseCase.call(event.id ?? "");
      emit(
          state.copyWith(isLoading: false, listNotification: listNotification));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          listNotification: state.listNotification
              .copyWith(errorMessage: ParseError.fromJson(e).message)));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }
}
