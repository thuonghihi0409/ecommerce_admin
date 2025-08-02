import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/review/domain/entities/review.dart';
import 'package:thuongmaidientu/features/review/domain/usecases/create_review_usecase.dart';
import 'package:thuongmaidientu/features/review/domain/usecases/get_list_review_usecase.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final GetListReviewUseCase _getListReviewUseCase;
  final CreateReviewUsecase _createReviewUsecase;

  ReviewBloc(this._getListReviewUseCase, this._createReviewUsecase)
      : super(ReviewState.empty()) {
    on<GetListReview>(_getListReview);
    on<CreateReview>(_createReview);
  }

  void _getListReview(GetListReview event, Emitter<ReviewState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await Future.delayed(const Duration(seconds: 1));
      final listReview = await _getListReviewUseCase.call(event.id ?? "");
      emit(state.copyWith(isLoading: false, listReview: listReview));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          listReview: state.listReview
              .copyWith(errorMessage: ParseError.fromJson(e).message)));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  void _createReview(CreateReview event, Emitter<ReviewState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _createReviewUsecase.call(event.review, event.productOrderItemId);

      emit(state.copyWith(isLoading: false));
      event.onSuccess?.call();
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      Helper.showToastBottom(
        message: ParseError.fromJson(e).message,
      );
    }
  }
}
