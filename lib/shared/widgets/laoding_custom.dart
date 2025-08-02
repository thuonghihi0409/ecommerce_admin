import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:thuongmaidientu/core/app_color.dart';

/// Show loader when waiting for something
class CustomLoading extends StatelessWidget {
  final bool isOverlay;
  final bool isLoading;
  final double strokeWidth;
  const CustomLoading(
      {super.key,
      this.isOverlay = false,
      this.isLoading = false,
      this.strokeWidth = 4});

  @override
  Widget build(BuildContext context) {
    if (isOverlay) {
      if (isLoading) {
        return SizedBox(
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  color: Colors.black.withAlpha(120),
                ),
              ),
              Positioned.fill(
                  child: Center(
                child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: const _Loading()),
              )),
            ],
          ),
        );
      }
      return const SizedBox();
    }
    if (isLoading) {
      return Center(
          child: _Loading(
        strokeWidth: strokeWidth,
      ));
    }
    return const SizedBox();
  }
}

class _Loading extends StatelessWidget {
  final double strokeWidth;
  const _Loading({this.strokeWidth = 2});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.flickr(
        leftDotColor: AppColor.greenColor,
        rightDotColor: AppColor.secondary,
        size: 50);
  }
}
