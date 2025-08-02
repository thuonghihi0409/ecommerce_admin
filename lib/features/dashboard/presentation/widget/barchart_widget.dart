import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/dashboard/domain/entities/revenue_entity.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';

class BarChartWidget extends StatefulWidget {
  final List<RevenueEntity>? revenue;
  const BarChartWidget({super.key, this.revenue});

  @override
  State<StatefulWidget> createState() => BarChartWidgetState();
}

class BarChartWidgetState extends State<BarChartWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.revenue == null || widget.revenue!.isEmpty) {
      return const Center();
    }
    return LayoutBuilder(builder: (context, constrains) {
      return AspectRatio(
        aspectRatio: 2.5,
        child: BarChart(
          BarChartData(
            barTouchData: barTouchData,
            titlesData: titlesData,
            borderData: FlBorderData(
                border: Border.all(width: 1, color: AppColor.greyColor)),
            barGroups: barGroups((widget.revenue ?? []).length >= 15 ? 13 : 25
                //constrains.maxWidth * 0.15
                ),
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
          fitInsideVertically: true,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 0,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            if (group.barRods.length <= rodIndex) return null;
            return BarTooltipItem(
              Helper.formatNumber(rod.toY.round()),
              AppTextStyles.textSize6(),
            );
          },
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            interval: (widget.revenue ?? []).length > 1 ? 1 : null,
            showTitles: true,
            reservedSize: 20,
            getTitlesWidget: (value, meta) {
              int index = value.toInt();

              return SideTitleWidget(
                space: 4,
                meta: meta,
                child: Text(
                    Helper.extractDatePart(widget.revenue?[index].key ?? ""),
                    style: AppTextStyles.textSize10()),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            interval: maxYValue / 5,
            getTitlesWidget: (value, meta) {
              return SideTitleWidget(
                space: 2,
                meta: meta,
                child: Text(
                  Helper.formatNumber(value.toInt()),
                  style: AppTextStyles.textSize8(),
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
    final maxRevenue = (widget.revenue ?? [])
        .map((e) => e.value ?? 0)
        .fold<double>(0, (prev, value) => value > prev ? value : prev);

    double estimatedMax = maxRevenue * 1.2;

    return estimatedMax == 0
        ? 500
        : ((estimatedMax / 500).ceil() * 500).toDouble();
  }

  List<BarChartGroupData> barGroups(double? width) =>
      (widget.revenue ?? []).asMap().entries.map((entry) {
        final toY = entry.value.value ?? 0;

        return BarChartGroupData(
          x: entry.key,
          barRods: [
            BarChartRodData(
              width: width,
              toY: entry.value.value ?? 0,
              // gradient: _barsGradient,
              color: AppColor.greenColor,
              borderRadius: BorderRadius.zero,
            )
          ],
          showingTooltipIndicators: toY > 0 ? [0] : [],
        );
      }).toList();
}
