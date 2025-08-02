import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/dashboard/domain/entities/top_ordered_product_entity.dart';

class BarChartRatingProduct extends StatefulWidget {
  final List<TopProductEntity>? topOrderedProductModel;
  const BarChartRatingProduct({super.key, this.topOrderedProductModel});

  @override
  State<StatefulWidget> createState() => BarChartProductState();
}

class BarChartProductState extends State<BarChartRatingProduct> {
  @override
  Widget build(BuildContext context) {
    if (widget.topOrderedProductModel == null ||
        widget.topOrderedProductModel!.isEmpty) {
      return const Center();
    }
    int count;
    if ((widget.topOrderedProductModel?.length ?? 0) > 10) {
      count = 10;
    } else {
      count = widget.topOrderedProductModel?.length ?? 1;
    }
    return LayoutBuilder(builder: (context, constrains) {
      return AspectRatio(
        aspectRatio: 2.5,
        child: BarChart(
          BarChartData(
            barTouchData: barTouchData,
            titlesData: titlesData(constrains.maxWidth / count),
            borderData: FlBorderData(
                border: Border.all(width: 1, color: AppColor.greyColor)),
            barGroups: barGroups(constrains.maxWidth / count),
            gridData: FlGridData(
              drawVerticalLine: false,
              horizontalInterval: maxYValue / 5,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey.withAlpha(80),
                  strokeWidth: 1,
                  dashArray: [2, 2],
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Colors.grey.withAlpha(80),
                  strokeWidth: 1,
                  dashArray: [2, 2],
                );
              },
            ),
            alignment: BarChartAlignment.spaceAround,
            maxY: maxYValue,
          ),
        ),
      );
    });
  }

  BarTouchData get barTouchData => BarTouchData(
      enabled: true,
      touchTooltipData: BarTouchTooltipData(
        getTooltipColor: (_) => Colors.transparent, // Màu nền của tooltip
        tooltipBorderRadius: BorderRadius.circular(8), // Bo góc
        fitInsideVertically: true,
        tooltipPadding: const EdgeInsets.all(8), // Padding đẹp hơn
        tooltipMargin: 8,
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          return BarTooltipItem(
            '${rod.toY}⭐',
            AppTextStyles.textSize16().copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ));

  FlTitlesData titlesData(double width) => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval:
                (widget.topOrderedProductModel ?? []).length > 1 ? 1 : null,
            reservedSize: 50,
            getTitlesWidget: (value, meta) {
              int index = value.toInt();
              return SideTitleWidget(
                space: 12,
                meta: meta,
                child: SizedBox(
                  width: width - 10,
                  child: Transform.rotate(
                    angle: -0.5,
                    child: Text(
                      widget.topOrderedProductModel?[index].name ?? "",
                      style: AppTextStyles.textSize14(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: maxYValue / 5,
            getTitlesWidget: (value, meta) {
              return SideTitleWidget(
                space: 2,
                //   axisSide: AxisSide.left,
                meta: meta,
                child: Text(
                  value.toString(),
                  style: AppTextStyles.textSize18(),
                  textAlign: TextAlign.end,
                ),
              );
            },
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          AppColor.greenColor,
          AppColor.yellowColor,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  double get maxYValue {
    return 5.0;
  }

  List<BarChartGroupData> barGroups(double? width) =>
      (widget.topOrderedProductModel ?? [])
          .asMap()
          .entries
          .map(
            (entry) => BarChartGroupData(
              x: entry.key,
              barRods: [
                BarChartRodData(
                  width: (width ?? 0) * 0.4,
                  toY: entry.value.avgRating?.toDouble() ?? 0,
                  // gradient: _barsGradient,
                  color: AppColor.primary,
                  borderRadius: BorderRadius.zero,
                )
              ],
              showingTooltipIndicators: [0],
            ),
          )
          .toList();
}
