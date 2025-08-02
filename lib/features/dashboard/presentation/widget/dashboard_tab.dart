import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/dashboard/domain/entities/statistic_entity.dart';
import 'package:thuongmaidientu/features/dashboard/presentation/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:thuongmaidientu/features/dashboard/presentation/widget/barchart_product.dart';
import 'package:thuongmaidientu/features/dashboard/presentation/widget/barchart_rating_product.dart';
import 'package:thuongmaidientu/features/dashboard/presentation/widget/barchart_widget.dart';
import 'package:thuongmaidientu/features/dashboard/presentation/widget/piechart_widget.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';

class DashboardTab extends StatefulWidget {
  final String type;
  const DashboardTab({super.key, required this.type});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab>
    with AutomaticKeepAliveClientMixin {
  late final _dashboardBloc = BlocProvider.of<DashboardBloc>(context);

  late StatisticEntity? _static;
  String _errorMessage = "";
  @override
  void didUpdateWidget(covariant DashboardTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.type != widget.type) {
      _getData();
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _getData();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _getData() async {
    if (widget.type == "day") {
      _dashboardBloc.add(const GetStatisticDay());
    }
    if (widget.type == "month") {
      _dashboardBloc.add(const GetStatisticMonth());
    }
    if (widget.type == "year") {
      _dashboardBloc.add(const GetStatisticYear());
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      if (widget.type == "day") {
        _static = state.statisticDay;
        _errorMessage = state.errorMessageDay;
      }
      if (widget.type == "month") {
        _static = state.statisticMonth;
        _errorMessage = state.errorMessageMonth;
      }
      if (widget.type == "year") {
        _static = state.statisticYear;
        _errorMessage = state.errorMessageYear;
      }

      if (_errorMessage.isNotEmpty) {
        return ErrorWidget(_errorMessage);
      }
      if (state.isLoadingDay && widget.type == "day") {
        return const CustomLoading(
          isLoading: true,
        );
      }
      if (state.isLoadingMonth && widget.type == "month") {
        return const CustomLoading(
          isLoading: true,
        );
      }
      if (state.isLoadingYear && widget.type == "year") {
        return const CustomLoading(
          isLoading: true,
        );
      }
      return NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          double height;

          height = context.heightScreen * 0.3;
          if ((scrollNotification.metrics.pixels) < -height) {
            _getData();
          }
          return false;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                8.h,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: _boxWidget(Column(
                        children: [
                          Text(
                            "key_total_order".tr(),
                            style: AppTextStyles.textSize16(
                                color: AppColor.greyColor),
                          ),
                          5.w,
                          Text(
                            "${_static?.totalOrders ?? 0}",
                            style: AppTextStyles.textSize20(),
                          ),
                        ],
                      )),
                    ),
                    15.w,
                    Expanded(
                      flex: 1,
                      child: _boxWidget(Column(
                        children: [
                          Text(
                            "key_total_user".tr(),
                            style: AppTextStyles.textSize16(
                                color: AppColor.greyColor),
                          ),
                          5.w,
                          Text(
                            (_static?.totalUsers ?? 0).toString(),
                            style: AppTextStyles.textSize20(),
                          ),
                        ],
                      )),
                    ),
                    15.w,
                    Expanded(
                      flex: 1,
                      child: _boxWidget(Column(
                        children: [
                          Text(
                            "key_total_store".tr(),
                            style: AppTextStyles.textSize16(
                                color: AppColor.greyColor),
                          ),
                          5.w,
                          Text(
                            (_static?.totalStores ?? 0).toString(),
                            style: AppTextStyles.textSize20(),
                          ),
                        ],
                      )),
                    ),
                    15.w,
                    Expanded(
                      child: SizedBox(
                        child: _boxWidget(Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${"key_total_product".tr()} ",
                              style: AppTextStyles.textSize16(
                                  color: AppColor.greyColor),
                            ),
                            Text(
                              "${_static?.totalProducts ?? 0}",
                              style: AppTextStyles.textSize20(
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        )),
                      ),
                    )
                  ],
                ),
                10.h,
                Text(
                  "key_transactions".tr(),
                  style: AppTextStyles.textSize14(),
                ),
                10.h,
                SizedBox(
                    height: 130,
                    child: PieChartWidget(
                      transaction: _static?.transactions,
                    )),
                15.h,
                Text(
                  "key_revenue".tr(),
                  style: AppTextStyles.textSize14(),
                ),
                15.h,
                BarChartWidget(
                  revenue: (_static?.revenue ?? []),
                ),
                10.h,
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 10,
                      color: AppColor.greenColor,
                    ),
                    30.w,
                    Text(
                      "key_product".tr(),
                      style: AppTextStyles.textSize14(),
                    )
                  ],
                ),
                20.h,
                Text(
                  "key_top_rating_product".tr(),
                  style: AppTextStyles.textSize14(),
                ),
                15.h,
                Container(
                    child: BarChartRatingProduct(
                  topOrderedProductModel: _static?.topAvgRatingProducts,
                )),
                20.h,
                Text(
                  "key_top_ordered_product".tr(),
                  style: AppTextStyles.textSize14(),
                ),
                15.h,
                Container(
                    child: BarChartProduct(
                  topOrderedProductModel: _static?.topOrderedProducts,
                )),
                10.h,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 5,
                      width: 5,
                      color: AppColor.primary,
                    ),
                    5.w,
                    Text(
                      widget.type == "day"
                          ? "key_this_month".tr()
                          : widget.type == "month"
                              ? "key_this_year".tr()
                              : "key_live_time".tr(),
                      style: AppTextStyles.textSize10(),
                    ),
                  ],
                ),
                30.h
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _boxWidget(Widget child) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: AppColor.primary.withAlpha(50),
          borderRadius: BorderRadius.circular(8)),
      child: child,
    );
  }
}
