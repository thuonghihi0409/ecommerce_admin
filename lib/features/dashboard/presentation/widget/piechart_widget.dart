import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/dashboard/domain/entities/transaction_entity.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';

class PieChartWidget extends StatefulWidget {
  final TransactionEntity? transaction;
  const PieChartWidget({super.key, this.transaction});

  @override
  State<StatefulWidget> createState() => PieChartWidgetState();
}

class PieChartWidgetState extends State<PieChartWidget> {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    if (widget.transaction == null ||
        (widget.transaction?.statuses ?? []).isEmpty) {
      return const Center();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: 0,
              sections: showingSections(),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.h,
              Text(
                "${"key_total_transactions".tr()}: ${widget.transaction?.total ?? 0}",
                style: AppTextStyles.textSize10(),
              ),
              5.h,
              Row(
                children: [
                  Container(
                    height: 10,
                    width: 15,
                    color: AppColor.greenColor,
                  ),
                  10.w,
                  Text(
                    "${"key_transaction_succeeded".tr()}: ${widget.transaction?.statuses?[0].count ?? 0}",
                    style: AppTextStyles.textSize10(),
                  ),
                ],
              ),
              5.h,
              Row(
                children: [
                  Container(
                    height: 10,
                    width: 15,
                    color: AppColor.greyColor,
                  ),
                  10.w,
                  Text(
                    "${"key_transaction_failed".tr()}: ${widget.transaction?.statuses?[1].count ?? 0}",
                    style: AppTextStyles.textSize10(),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    if (widget.transaction?.statuses == null ||
        widget.transaction!.statuses!.isEmpty) {
      return [];
    }

    double totalValue = widget.transaction!.statuses!
        .map((e) => e.count?.toDouble() ?? 0)
        .fold(0, (prev, value) => prev + value);

    if (totalValue == 0) {
      return [
        PieChartSectionData(
            value: 1, color: AppColor.greenColor, radius: 60, showTitle: false)
      ];
    }

    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final radius = isTouched ? 65.0 : 60.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            showTitle: false,
            color: AppColor.greenColor,
            value: widget.transaction?.statuses?[0].count?.toDouble() ?? 1,
            radius: radius,
            titleStyle: AppTextStyles.textSize10(),
          );
        case 1:
          return PieChartSectionData(
            showTitle: false,
            color: AppColor.secondary,
            value: widget.transaction?.statuses?[1].count?.toDouble(),
            radius: radius,
            titleStyle: AppTextStyles.textSize10(),
          );

        default:
          throw Exception();
      }
    });
  }
}
