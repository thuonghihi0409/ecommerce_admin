import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/review/presentation/bloc/review_bloc/review_bloc.dart';
import 'package:thuongmaidientu/features/review/presentation/widget/review_item_widget.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';

class ReviewPage extends StatefulWidget {
  final ProductDetail? productDetail;
  const ReviewPage({super.key, required this.productDetail});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _getDate();
  }

  _getDate() async {
    context
        .read<ReviewBloc>()
        .add(GetListReview(id: widget.productDetail?.productId ?? ""));
  }

  void _onRefresh() {}

  void _onLoading() {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewBloc, ReviewState>(builder: (context, state) {
      return Scaffold(
        appBar: CustomAppBar(
          title: "key_review".tr(),
        ),
        body: Builder(builder: (context) {
          if (state.isLoading) {
            return const CustomLoading(
              isLoading: true,
            );
          }
          return Column(
            children: [
              5.h,
              Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(8),
                  itemCount: state.listReview.results?.length ?? 0,
                  itemBuilder: (context, index) {
                    final review = state.listReview.results?[index];
                    return ReviewItemWidget(review: review);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                ),
              ),
            ],
          );
        }),
      );
    });
  }
}
