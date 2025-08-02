import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/dashboard/presentation/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:thuongmaidientu/features/dashboard/presentation/widget/dashboard_tab.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String type = "year";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(builder: (context1, constraint) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            color: AppColor.whiteColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                5.h,
                Text(
                  "key_dashboard".tr(),
                  style: AppTextStyles.textSize12(),
                ),
                3.h,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      BlocProvider.of<ProfileBloc>(context).state.store?.name ??
                          "",
                      style: AppTextStyles.textSize20(),
                    ),
                    TimeFilterButtons(
                      onChange: (index) {
                        if (index == 0) {
                          setState(() {
                            type = "day";
                          });
                        }
                        if (index == 1) {
                          setState(() {
                            type = "month";
                          });
                        }
                        if (index == 2) {
                          setState(() {
                            type = "year";
                          });
                        }
                      },
                    ),
                  ],
                ),
                5.h,
                Expanded(
                  child: DashboardTab(type: type),
                ),
              ],
            ),
          );
        }),
      );
    });
  }
}

class TimeFilterButtons extends StatefulWidget {
  final Function(int)? onChange;
  const TimeFilterButtons({super.key, this.onChange});

  @override
  _TimeFilterButtonsState createState() => _TimeFilterButtonsState();
}

class _TimeFilterButtonsState extends State<TimeFilterButtons> {
  int selectedIndex = 0;

  final List<String> labels = [
    "key_this_month".tr(),
    "key_this_year".tr(),
    "key_live_time".tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(labels.length, (index) {
        final isSelected = selectedIndex == index;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onChange?.call(index);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              decoration: BoxDecoration(
                color: isSelected ? AppColor.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColor.primary : Colors.grey.shade400,
                ),
              ),
              child: Text(
                labels[index],
                style: AppTextStyles.textSize10(
                  color: isSelected ? AppColor.whiteColor : AppColor.blackColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
